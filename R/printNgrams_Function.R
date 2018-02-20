#' @title Produces a bar graph of the most frequent n-grams found within a corpus
#' @description description
#' @param data.td A tidy dataset
#' @param ngram A user defined integer representing the number of tokens to analyze, 'n'
#' @param num A user definied number of most frequenct ngrams to plot in the bar graph
#' @return A bar graph of the most frequent \code{ngram} found within a corpus
#' @export
#' @import dplyr ggplot2 
#' @importFrom stats reorder

####################PRINT NGRAM FUNCTION##################

ngram.print<-function(data.td, ngram=1, num=15){
  ngram<-quo(ngram)
  num <- quo(num)
  if(class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  if(!is.integer(ngram)| ngram >5) stop('The n-gram must be an integer and less than 6')
  
  if(ngram==1){
    
    data.unigram <- data.td %>%
      unnest_tokens(~unigram, ~text) %>%
      filter(!~unigram %in% c(~stop_words$word)) %>% 
      count(~unigram, sort =T) %>%
      ungroup() %>% 
      print()
    
    data.unigram %>%
      top_n(num) %>%
      ggplot(aes(data=~unigram, reorder(~unigram,~n), ~n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=20)) +
      ggtitle("Term Frequency")+
      labs(x = "term", y = "frequency") +
      coord_flip()
    
    
    
  } else if(ngram==2){
    data.bigram <- data.td %>%
      unnest_tokens(~bigram, ~text, token = "ngrams", n=2) %>%  
      separate(~bigram,c("word1","word2"), sep = " ") %>% 
      filter(!~word1 %in% c(stop_words$word,'[0-9]+')) %>% 
      filter(!~word2 %in% c(stop_words$word,'[0-9]+')) %>%
      unite(~bigram, ~word1, ~word2, sep = " ") %>% 
      count(~bigram, sort =T) %>%
      ungroup() %>% 
      print()  
    
    
    data.bigram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(~bigram,~n), ~n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=20)) +
      ggtitle("Bigram Frequency")+
      labs(x = "bigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==3){
    data.trigram <- data.td %>%
      unnest_tokens(~trigram, ~text, token = "ngrams", n =3) %>%
      separate(~trigram,c("word1","word2", "word3"), sep = " ") %>%
      filter(!~word1 %in% c(stop_words$word)) %>%
      filter(!~word2 %in% c(stop_words$word)) %>%
      filter(!~word3 %in% c(stop_words$word)) %>%
      unite(~trigram, ~word1, ~word2, ~word3, sep = " ") %>% 
      count(~trigram, sort =T) %>%
      ungroup() %>% 
      print()
    
    data.trigram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(~trigram,~n), ~n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=20)) +
      ggtitle("Trigram Frequency")+
      labs(x = "trigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==4){
    data.fourgram <- data.td %>%
      unnest_tokens(~fourgram, ~text, token = "ngrams", n =4) %>%
      separate(~fourgram,c("word1","word2", "word3", "word4"), sep = " ") %>%
      filter(!~word1 %in% c(stop_words$word)) %>%
      filter(!~word2 %in% c(stop_words$word)) %>%
      filter(!~word3 %in% c(stop_words$word)) %>%
      filter(!~word4 %in% c(stop_words$word)) %>%
      unite(~fourgram, ~word1, ~word2, ~word3,~word4, sep = " ") %>%
      count(~fourgram, sort =T) %>% 
      print()
    
    data.fourgram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(~fourgram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=20)) +
      ggtitle("Fourgram Frequency")+
      labs(x = "fourgram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==5){
    data.fivegram <- data.td %>%
      unnest_tokens(~fivegram, ~text, token = "ngrams", n =5) %>%
      separate(~fivegram,c("word1","word2", "word3", "word4", "word5"), sep = " ") %>%
      filter(!~word1 %in% c(stop_words$word)) %>%
      filter(!~word2 %in% c(stop_words$word)) %>%
      filter(!~word3 %in% c(stop_words$word)) %>%
      filter(!~word4 %in% c(stop_words$word)) %>%
      filter(!~word5 %in% c(stop_words$word)) %>%
      unite(~fivegram, ~word1, ~word2, ~word3, ~word4, ~word5, sep = " ") %>% 
      count(~fivegram, sort =T) %>% 
      print()
    
    data.fivegram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(~fivegram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=20)) +
      ggtitle("Fivegram Frequency")+
      labs(x = "fivegram", y = "frequency") +
      coord_flip()
  }
  
}  
