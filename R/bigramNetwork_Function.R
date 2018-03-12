#' @title Network graph of most frequent bigrams found throughout the corpus
#' @description This function visualizes the most frequent words that co-occur
#'   throughout a corpus.
#' @details This function identifies all of the bigrams (two word co-occurrences
#'   in a sequence of text) in a corpus, sums the frequency of occurrence for 
#'   each bigram, and sorts the list in descending order. The function then 
#'   generates an undirected network graph connecting each word (node) in the
#'   bigram. These words are connected by edges (lines) whose thickness varies based
#'   on the frequency of occurrence for each bigram.
#' @param data.td A tidy dataset
#' @param freq A user defined numeric vector containing an user defined limit of
#'   most frequent bigrams to include
#' @return A network graph of the most frequent bigrams down to a user defined \code{freq}
#' @export
#' @import tidytext ggplot2 ggraph widyr tidyr dplyr rlang
#' @importFrom igraph graph_from_data_frame
#' @examples 
#' \donttest{
#' bigram.network(Articles, 200)
#' }


#########Bigram Network################
bigram.network <- function(data.td, freq){
  `%>%` <- dplyr::`%>%`
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  if(freq%%1 != 0) stop('The frequency must be an integer')
  text <-quo(text)
  bigram<-quo(bigram)
  word1 <- quo(word1)
  # stop_words<-quo(stop_words)
  word2<- quo(word2)
  name <- quo(name)
  data.bigram <- data.td %>%
    unnest_tokens(bigram, text, token = "ngrams", n=2) %>%  
    separate(bigram,c("word1","word2"), sep = " ") %>% 
    filter(!word1 %in% c(tidytext::stop_words$word,'[0-9]+')) %>% 
    filter(!word2 %in% c(tidytext::stop_words$word,'[0-9]+')) %>%
    count(word1, word2, sort =T)
  
  bi.graph <- data.bigram %>% 
    filter(n>freq) %>% 
    graph_from_data_frame()
  
  
  set.seed(2017)
  
  ggraph(bi.graph, layout = "fr")+
    geom_edge_link(aes(edge_alpha = n, edge_width = n), show.legend = T)+
    theme(legend.text=element_text(size=16))+
    geom_node_point(color = "lightblue", size = 4)+
    geom_node_text(aes(label=name),
                   repel = T,
                   check_overlap = T, size = 7)+
    ggtitle("Bigram Network",subtitle = paste0("n >  ",freq))
}


