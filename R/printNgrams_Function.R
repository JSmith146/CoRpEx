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
  text<-dplyr::quo(text)
  word1<- dplyr::quo(word1)
  word2<- dplyr::quo(word2)
  word3<- dplyr::quo(word3)
  word4<- dplyr::quo(word4)
  word5<- dplyr::quo(word5)
  unigram<-dplyr::quo(unigram)
  bigram<-dplyr::quo(bigram)
  trigram<-dplyr::quo(trigram)
  fourgram<-dplyr::quo(fourgram)
  fivegram<-dplyr::quo(fivegram)
 
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  if(ngram%%1 != 0) stop('The frequency must be an integer')
  if(num%%1 != 0) stop('The frequency must be an integer')
  if(ngram>5) stop('The n-gram input must be between 1 and 5')
  if(ngram==1){
    
    data.unigram <- data.td %>%
      tidytext::unnest_tokens(unigram, text) %>%
      dplyr::filter(!unigram %in% c(tidytext::stop_words$word)) %>% 
      dplyr::count(unigram, sort =T) %>%
      dplyr::ungroup() %>% 
      print()
    
    data.unigram %>%
      dplyr::top_n(num) %>%
      ggplot(aes(data=unigram, reorder(unigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Term Frequency")+
      labs(x = "term", y = "frequency") +
      coord_flip()
    
    
    
  } else if(ngram==2){
    data.bigram <- data.td %>%
      tidytext::unnest_tokens(bigram, text, token = "ngrams", n=2) %>%  
      tidyr::separate(bigram,c("word1","word2"), sep = " ") %>% 
      dplyr::filter(!word1 %in% c(tidytext::stop_words$word,'[0-9]+')) %>% 
      dplyr::filter(!word2 %in% c(tidytext::stop_words$word,'[0-9]+')) %>%
      tidyr::unite(bigram, word1, word2, sep = " ") %>% 
      dplyr::count(bigram, sort =T) %>%
      dplyr::ungroup() %>% 
      print()  
    
    
    data.bigram %>%
      dplyr::top_n(num) %>%  
      ggplot2::ggplot(ggplot2::aes(reorder(bigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Bigram Frequency")+
      labs(x = "bigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==3){
    data.trigram <- data.td %>%
      tidytext::unnest_tokens(trigram, text, token = "ngrams", n =3) %>%
      tidyr::separate(trigram,c("word1","word2", "word3"), sep = " ") %>%
      dplyr::filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      tidyr::unite(trigram, word1, word2, word3, sep = " ") %>% 
      dplyr::count(trigram, sort =T) %>%
      dplyr::ungroup() %>% 
      print()
    
    data.trigram %>%
      dplyr::top_n(num) %>%  
      ggplot2::ggplot(ggplot2::aes(reorder(trigram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Trigram Frequency")+
      labs(x = "trigram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==4){
    data.fourgram <- data.td %>%
      tidytext::unnest_tokens(fourgram, text, token = "ngrams", n =4) %>%
      tidyr::separate(fourgram,c("word1","word2", "word3", "word4"), sep = " ") %>%
      dplyr::filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word4 %in% c(tidytext::stop_words$word)) %>%
      tidyr::unite(fourgram, word1, word2, word3,word4, sep = " ") %>%
      dplyr::count(fourgram, sort =T) %>% 
      print()
    
    data.fourgram %>%
      dplyr::top_n(num) %>%  
      ggplot2::ggplot(ggplot2::aes(reorder(fourgram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Fourgram Frequency")+
      labs(x = "fourgram", y = "frequency") +
      coord_flip()
    
  }else if(ngram==5){
    data.fivegram <- data.td %>%
      tidytext::unnest_tokens(fivegram, text, token = "ngrams", n =5) %>%
      tidyr::separate(fivegram,c("word1","word2", "word3", "word4", "word5"), sep = " ") %>%
      dplyr::filter(!word1 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word2 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word3 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word4 %in% c(tidytext::stop_words$word)) %>%
      dplyr::filter(!word5 %in% c(tidytext::stop_words$word)) %>%
      tidyr::unite(fivegram, word1, word2, word3, word4, word5, sep = " ") %>% 
      dplyr::count(fivegram, sort =T) %>% 
      print()
    
    data.fivegram %>%
      dplyr::top_n(num) %>%  
      ggplot2::ggplot(ggplot2::aes(reorder(fivegram,n), n, sort=T)) +
      geom_col() +
      theme(text = element_text(size=26)) +
      ggtitle("Fivegram Frequency")+
      labs(x = "fivegram", y = "frequency") +
      coord_flip()
  }
  
}  
