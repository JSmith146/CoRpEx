#' @title Produces a plot identifying the estimated correct number of topics to choose. Based on the `ldatuning` package.
#' @description description
#' @param data.td A tidy dataset
#' @param x A user defined term sparsity limit
#' @return Plot indicating the estimated number of topics found within the corpus, \code{data.td}
#' @export
#' @import tidytext tm dplyr ggplot2 scales ldatuning

####Topic Model Number####
topic.number <- function(data.td,x=.90){
  x<- quo(x)
  #Error checking performs check of data class
  if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')

  # Convert the data frame to a Corpus
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
  
  # Find the optimal number of topics to perform LDA with
  result <- FindTopicsNumber(
    data_dtm,
    topics = seq(from = 2, to = 16, by = 2),
    metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"),
    method = "Gibbs",
    control = list(seed = 1234),
    mc.cores = 2L, #make sure this is appropriate number of cores you wish to use
    verbose = TRUE)
  ###Plot result
  FindTopicsNumber_plot(result)
}
