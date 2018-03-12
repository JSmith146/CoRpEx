#' @title Estimate the correct number of hidden topics to choose. 
#' @description This function provides a plot to assist a user in identifying
#'   the correct numner of \emph{k} topics.
#' @details This function allows for the effective transition of data into the
#'   \code{ldatuning} package. Provided the number of topics \code{k}, the 
#'   function will generate both a maximization and minization plot indicating 
#'   the optimal estimated number of topics for a specified corpus.
#' @param data.td A tidy dataset
#' @param x A user defined term sparsity limit
#' @param k A user defined number of topics to identify
#' @return Plot indicating the estimated number of topics found within the corpus, \code{data.td}
#' @export
#' @import tidytext dplyr ggplot2 scales ldatuning rlang tm
#' @examples
#' \donttest{
#' topic.number(Articles,k=50)
#' }


####Topic Model Number####
topic.number <- function(data.td,x=.90,k=16){
  `%>%` <- dplyr::`%>%`
  
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  
  # Convert the data frame to a Corpus
  custom_reader <- readTabular(
    mapping = list(title = "title",author = "author",
                   date = "date", url = "url", source = "source",
                   content = "text", id = "id"))
  
  data.td.corp <-tm::VCorpus(
    tm::DataframeSource(data.td), 
    readerControl = list(reader = custom_reader))
  
  # Convert the corpus to a Document Term Matrix
  data_dtm <- tm::DocumentTermMatrix(data.td.corp, control = list( stemming = F, stopwords = TRUE,
                                                               minWordLength = 2, removeNumbers = TRUE, removePunctuation = TRUE))
  
  data_dtm <- tm::removeSparseTerms(data_dtm, x)
  
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
