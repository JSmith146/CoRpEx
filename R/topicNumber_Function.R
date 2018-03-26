#' @title Estimate the correct number of hidden topics to choose. 
#' @description This function provides a plot to assist a user in identifying
#'   the correct numner of \emph{k} topics.
#' @details This function allows for the effective transition of data into the
#'   \code{ldatuning} package. Provided the number of topics \code{k}, the 
#'   function will generate both a maximization and minization plot indicating 
#'   the optimal estimated number of topics for a specified corpus.
#' @param data.td A tidy dataset
#' @param k A user defined number of topics to identify
#' @return Plot indicating the estimated number of topics found within the corpus, \code{data.td}
#' @export
#' @import tidytext dplyr ggplot2 scales ldatuning rlang tm
#' @examples
#' \donttest{
#' topic.number(Articles,k=50)
#' }


####Topic Model Number####
topic.number <- function(data.td,k=16){
  `%>%` <- dplyr::`%>%`
  text <-dplyr::quo(text)
  word <-dplyr::quo(word)
  
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  
  # Convert the data frame to a Corpus
  data.td$id <- as.character(data.td$id)
  
  data_dtm <- data.td %>% 
    dplyr::group_by(id) %>% 
    tidytext::unnest_tokens(word,text) %>% 
    dplyr::anti_join(tidytext::stop_words) %>% 
    dplyr::count(id, word, sort =T) %>% 
    tidytext::cast_dtm(id, word,n)
  
  # Find the optimal number of topics to perform LDA with
  result <- ldatuning::FindTopicsNumber(
    data_dtm,
    topics = seq(from = 2, to = k, by = 2),
    metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
    method = "Gibbs",
    control = list(seed = 1234),
    mc.cores = 2L, #make sure this is appropriate number of cores you wish to use
    verbose = TRUE)
  ###Plot result
  ldatuning::FindTopicsNumber_plot(result)
}
