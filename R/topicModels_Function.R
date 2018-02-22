#' @title Determines and classifies documents within a corpus to a user defined number of topics
#' @description description
#' @param data.td A tidy dataset
#' @param k User defined number of topics
#' @param x A user defined term sparsity limit
#' @return Attaches a new column to \code{data.td} identifying each document in a corpus as belonging to a specific topic
#' @export
#' @import tm ldatuning topicmodels
#' @importFrom utils View




####Find Topics####
topic.models <- function(data.td,k=16,x=.90){
  
  k<- quo(k)
  x<- quo(x)
  #Error checking performs check of data class
  if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  

  custom_reader1 <- readTabular(
    mapping = list(title = "title",author = "author",
                   date = "date", url = "url", source = "source",
                   content = "text", id = "ArticleNo"))
  
  data.td.corp <-VCorpus(
    DataframeSource(data.td), 
    readerControl = list(reader = custom_reader1))
  
  # Convert the corpus to a Document Term Matrix
  data_dtm <- DocumentTermMatrix(data.td.corp, control = list( stemming = F, stopwords = TRUE,
                                                               minWordLength = 2, removeNumbers = TRUE, removePunctuation = TRUE))
  
  data_dtm <- removeSparseTerms(data_dtm, x)

  
  
  #Set parameters for Gibbs sampling
  burnin <- 4000
  iter <- 2000
  thin <- 500
  seed <-list(2003,5,63,100001,765)
  nstart <- 5
  best <- TRUE
  
  
  
  #Run LDA using Gibbs sampling
  ldaOut <-LDA(data_dtm,k, method ="Gibbs", control=list(nstart=nstart, 
                                                         seed = seed, best=best, burnin = burnin, iter = iter, thin=thin))
  
  ldaOut.topics <- as.matrix(topics(ldaOut))
  ldaOut.terms <- as.matrix(terms(ldaOut,10))
  #probabilities associated with each topic assignment
  topicProbabilities <- as.data.frame(ldaOut@gamma)
  
  data.topics<- topics(ldaOut,1)
  data.terms<- as.data.frame(terms(ldaOut, 10), stringsAsFactors = FALSE)
  print(data.terms)
  View(data.terms)
  
  # Creates a dataframe to store the Lesson Number and the most likely topic
  doctopics.df <- as.data.frame(data.topics)
  doctopics.df <- dplyr::transmute(doctopics.df, LessonId = rownames(ldaOut.topics), Topic = data.topics)
  doctopics.df$ArticleNo <- as.character(doctopics.df$LessonId)
  
  # ## Adds topic number to original dataframe of lessons
  
  data.td <-dplyr::inner_join(data.td, doctopics.df, by = "ArticleNo")
}
