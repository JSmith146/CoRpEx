#' @title Inverted bar graph of the most frequent n-grams found within a corpus
#' @description This function identifies the top number(\code{num}) of user specified
#' n-grams(\code{ngram}) and provides a visual of each.
#' @details This function identifies all of the user specified n-grams (\emph{n} word co-occurrences
#'   in a sequence of text) in a corpus, sums the frequency of occurrence for
#'   each n-gram, and sorts the list in descending order. The function then
#'   provides an inverted bar chart identifying each n-gram and its frequency of
#'   occurrence down to a user specified lower-bound (\code{freq}).
#' @param data.td A tidy dataset
#' @param ngram A user defined integer representing the number of tokens to analyze, 'n'
#' @param num A user definied number of most frequenct ngrams to plot in the bar graph
#' @return A bar graph of the most frequent \code{ngram} found within a corpus
#' @export
#' @import dplyr ggplot2 rlang
#' @importFrom stats reorder
#' @examples
#' \donttest{
#' ngram.print(Articles, 2, 20)
#' }

####################PRINT NGRAM FUNCTION##################

ngram.print<-function(data.td, ngram=1, num=15){
  `%>%` <- dplyr::`%>%`
  # ngram<-quo(ngram)
  # num <- quo(num)
  text<-quo(text)
  word1<- quo(word1)
  word2<- quo(word2)
  word3<- quo(word3)
  word4<- quo(word4)
  word5<- quo(word5)
  unigram<-quo(unigram)
  bigram<-quo(bigram)
  trigram<-quo(trigram)
  fourgram<-quo(fourgram)
  fivegram<-quo(fivegram)
 
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  if(ngram%%1 != 0) stop('The frequency must be an integer')
  if(num%%1 != 0) stop('The frequency must be an integer')
  if(ngram>5) stop('The n-gram input must be between 1 and 5')
  if(ngram==1){
    
    data.unigram <- data.td %>%
      unnest_tokens(unigram, text) %>%
      filter(!unigram %in% c(tidytext::stop_words$word)) %>% 
      count(unigram, sort =T) %>%
      ungroup() %>% 
      print()
    
    data.unigram %>%
      top_n(num) %>%
      ggplot(aes(data=unigram, reorder(unigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Term Frequency")+
      labs(x = "term", y = "frequency") +
      coord_flip()
    
    
    
  } else if(ngram==2){
    data.bigram <- data.td %>%
      unnest_tokens(bigram, text, token = "ngrams", n=2) %>%  
      separate(bigram,c("word1","word2"), sep = " ") %>% 
      filter(!word1 %in% c(tidytext::stop_words$word,'[0-9]+')) %>% 
      filter(!word2 %in% c(tidytext::stop_words$word,'[0-9]+')) %>%
      unite(bigram, word1, word2, sep = " ") %>% 
      count(bigram, sort =T) %>%
      ungroup() %>% 
      print()  
    
    
    data.bigram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(bigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Bigram Frequency")+
      labs(x = "bigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==3){
    data.trigram <- data.td %>%
      unnest_tokens(trigram, text, token = "ngrams", n =3) %>%
      separate(trigram,c("word1","word2", "word3"), sep = " ") %>%
      filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      unite(trigram, word1, word2, word3, sep = " ") %>% 
      count(trigram, sort =T) %>%
      ungroup() %>% 
      print()
    
    data.trigram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(trigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Trigram Frequency")+
      labs(x = "trigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==4){
    data.fourgram <- data.td %>%
      unnest_tokens(fourgram, text, token = "ngrams", n =4) %>%
      separate(fourgram,c("word1","word2", "word3", "word4"), sep = " ") %>%
      filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      filter(!word4 %in% c(tidytext::stop_words$word)) %>%
      unite(fourgram, word1, word2, word3,word4, sep = " ") %>%
      count(fourgram, sort =T) %>% 
      print()
    
    data.fourgram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(fourgram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Fourgram Frequency")+
      labs(x = "fourgram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==5){
    data.fivegram <- data.td %>%
      unnest_tokens(fivegram, text, token = "ngrams", n =5) %>%
      separate(fivegram,c("word1","word2", "word3", "word4", "word5"), sep = " ") %>%
      filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      filter(!word4 %in% c(tidytext::stop_words$word)) %>%
      filter(!word5 %in% c(tidytext::stop_words$word)) %>%
      unite(fivegram, word1, word2, word3, word4, word5, sep = " ") %>% 
      count(fivegram, sort =T) %>% 
      print()
    
    data.fivegram %>%
      top_n(num) %>%  
      ggplot(aes(reorder(fivegram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Fivegram Frequency")+
      labs(x = "fivegram", y = "frequency") +
      coord_flip()
  }
  
}  
