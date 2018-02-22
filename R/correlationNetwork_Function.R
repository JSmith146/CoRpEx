#' @title Produces a network graph of the most correlated pairs of terms found throughout the corpus
#' @description description
#' @param data.td A tidy dataset
#' @param corlimit A user defined numeric correlation limit between 0 and 1
#' @return A network graph of the most frequent bigrams down to a user defined \code{corlimit}
#' @export
#' @import tidytext widyr dplyr ggplot2 ggraph 
#' @importFrom igraph graph_from_data_frame


  #########Word Correlation######
   cor.network<-function(data.td,corlimit){
     #Error Checking
     if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
     if(length(corlimit)!=1 | !is.numeric(corlimit) | corlimit >1 | corlimit <0) stop('Correlation limit must be a single value between 0 and 1')
     
    book_words <- data.td %>%
      unnest_tokens(~word,~text) %>% 
      filter(!~word %in% stop_words$word) %>% 
      count(~ArticleNo, ~word, sort = TRUE) %>%
      ungroup() %>%
      group_by(~ArticleNo) %>%
      top_n(25)
    
    word_cor <- book_words %>% 
      group_by(~word) %>% 
      filter(n()>=20) %>%
      pairwise_cor(~word,~ArticleNo) %>% 
      arrange(desc(~correlation))
    
    set.seed(2016)
    
    word_cor %>%
      filter(~correlation > corlimit) %>%
      graph_from_data_frame() %>%
      ggraph(layout = "fr") +
      geom_edge_link(aes(edge_alpha = ~correlation, edge_width = ~correlation), show.legend = T) +
      geom_node_point(color = "lightblue", size = 4) +
      geom_node_text(aes(label = ~name), repel = TRUE, size = 7) +
      theme_void()+
      ggtitle("Correlation Network",subtitle = paste0("Correlation = ",corlimit))
  }
  
