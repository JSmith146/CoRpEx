#' @title Uncover and assign topics to documents within a corpus
#' @description This function utilizes Latent Dirichlet Allocation (LDA) and the
#'   \code{topicmodels} package to allow a user to define a specified number of
#'   \code{k} hidden topics. Once identified, each document's topic is assigned
#'   to a new column in the dataset for further analysis.
#' @param data.td A tidy dataset
#' @param k User defined number of topics
#' @return Attaches a new column to \code{data.td} identifying each document in a corpus as belonging to a specific topic
#' @export
#' @import topicmodels tm dplyr
#' @importFrom utils View
#' @examples
#' \donttest{
#' Articles<-topic.models(Articles, k=10)
#' }





####Find Topics####
topic.models <- function(data.td,k=2){
  
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  text <-dplyr::quo(text)
  word <-dplyr::quo(word)
  data.td$id <- as.character(data.td$id)
  
  data_dtm <- data.td %>% 
    dplyr::group_by(id) %>% 
    tidytext::unnest_tokens(word,text) %>% 
    dplyr::anti_join(tidytext::stop_words) %>% 
    dplyr::count(id, word, sort =T) %>% 
    tidytext::cast_dtm(id, word,n)
  
  
  #Set parameters for Gibbs sampling
  burnin <- 4000
  iter <- 2000
  thin <- 500
  seed <-list(2003,5,63,100001,765)
  nstart <- 5
  best <- TRUE
  
  
  
  #Run LDA using Gibbs sampling
  ldaOut <-topicmodels::LDA(data_dtm,k, method ="Gibbs", control=list(nstart=nstart, 
                                                         seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))
  
  ldaOut.topics <- as.matrix(topicmodels::topics(ldaOut))
  ldaOut.terms <- as.matrix(topicmodels::terms(ldaOut,10))
  #probabilities associated with each topic assignment
  topicProbabilities <- as.data.frame(ldaOut@gamma)
  
  data.topics<- topicmodels::topics(ldaOut,1)
  data.terms<- as.data.frame(topicmodels::terms(ldaOut, 10), stringsAsFactors = FALSE)
  print(data.terms)

  
  # Creates a dataframe to store the Lesson Number and the most likely topic
  doctopics.df <- as.data.frame(data.topics)
  doctopics.df <- dplyr::transmute(doctopics.df, id = rownames(ldaOut.topics), Topic = data.topics)
  # doctopics.df$id <- as.character(doctopics.df$LessonId)
  
  # ## Adds topic number to original dataframe of lessons
  
  data.td <-dplyr::inner_join(data.td, doctopics.df, by = "id")
  return(data.td)
}
