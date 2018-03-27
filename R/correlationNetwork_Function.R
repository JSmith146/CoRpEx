#' @title Network graph of the most correlated pairs of terms found throughout the corpus
#' @description This function visualizes the most frequent pair of terms found 
#'   throughout a corpus of documents based on the Phi Correlation 
#'   Coefficient. The function will only produce word pairs at or above a
#'   provided correlation limit.
#' @details This function identifies all of the  terms found with in a corpus
#'   and sums the number of times each term is found within the same document
#'   relative to the other terms. With this information, each pair of terms is
#'   provided a correlation value using the Phi Coefficient. The function then generates
#'   an undirected network graph connecting each word (node) in a word pair.
#'   Correlated words are then connected by edges (lines) whose thickness varies based on
#'   the value of the correlation coefficient for each word pair.
#' @param data.td A tidy dataset
#' @param corlimit A user defined numeric correlation limit between 0 and 1
#' @return A network graph of the most correlated word pairs down to a user defined \code{corlimit}
#' @export
#' @import tidytext widyr dplyr ggplot2 ggraph 
#' @importFrom igraph graph_from_data_frame
#' @examples
#' \donttest{
#' cor.network(Articles, 200)
#' }
      
  



  #########Word Correlation######
   cor.network<-function(data.td,corlimit){
     `%>%` <- dplyr::`%>%`
     text<-quo(text)
     id <- quo(id)
     name<-quo(name)
     correlation<-quo(correlation)
     #Error Checking
     if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
     if(length(corlimit)!=1 | !is.numeric(corlimit) | corlimit >1 | corlimit <0) stop('Correlation limit must be a single value between 0 and 1')
     
    book_words <- data.td %>%
      unnest_tokens(word,text) %>% 
      filter(!word %in% tidytext::stop_words$word) %>% 
      count(id, word, sort = TRUE) %>%
      ungroup() %>%
      group_by(id) %>%
      top_n(25)
    
    word_cor <- book_words %>% 
      group_by(word) %>% 
      filter(n()>=20) %>%
      pairwise_cor(word,id) %>% 
      arrange(desc(correlation))
    
    set.seed(2016)
    
    word_cor %>%
      filter(correlation > corlimit) %>%
      graph_from_data_frame() %>%
      ggraph(layout = "fr") +
      geom_edge_link(aes(edge_alpha = correlation, edge_width = correlation), show.legend = T) +
      theme(legend.text=element_text(size=16))+
      geom_node_point(color = "lightblue", size = 4) +
      geom_node_text(aes(label = name), repel = TRUE, size = 7) +
      ggtitle("Correlation Network",subtitle = paste0("Correlation = ",corlimit))
  }
  
