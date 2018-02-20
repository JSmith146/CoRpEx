#' @title Produces a network graph of most frequent bigrams found throughout the corpus
#' @description description
#' @param data.td A tidy dataset
#' @param freq A user defined numeric vector containing an user defined limit of most frequent bigrams to include
#' @return A network graph of the most frequent bigrams down to a user defined \code{freq}
#' @export
#' @import tidytext ggplot2 ggraph widyr tidyr dplyr
#' @importFrom igraph graph_from_data_frame


#########Bigram Network################
bigram.network <- function(data.td, freq){
  if(class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  if(!is.integer(freq)) stop('The frequency must be an integer')
  
  
  data.bigram <- data.td %>%
    unnest_tokens(~bigram, ~text, token = "ngrams", n=2) %>%  
    separate(~bigram,c("word1","word2"), sep = " ") %>% 
    filter(!~word1 %in% c(stop_words$word,'[0-9]+')) %>% 
    filter(!~word2 %in% c(stop_words$word,'[0-9]+')) %>%
    count(~word1, ~word2, sort =T)
  
  bi.graph <- data.bigram %>% 
    filter(~n>freq) %>% 
    graph_from_data_frame()
  
  
  set.seed(2017)
  
  ggraph(bi.graph, layout = "fr")+
    geom_edge_link(aes(edge_alpha = n, edge_width = n), show.legend = T)+
    geom_node_point(color = "lightblue", size = 4)+
    geom_node_text(aes(label=~name), vjust = 1, hjust=1,
                   repel = T,
                   check_overlap = T, size = 7)+
    ggtitle("Bigram Network",subtitle = paste0("n >  ",freq))
}


