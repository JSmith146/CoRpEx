#' @title Time series plot of terms associated with a specified word.
#' @description Create a time series line plot of words associated with a
#'   specified keyword. Words are associated down to the defined correlation
#'   limit. Terms must be a character vector containing no spaces.
#' @details This function first identifies each document which contains the user
#'   specified \code{keyword} and omits all those which do not. The function 
#'   next finds all words correlated with the user specified \code{keyword} down
#'   to the user defined  correlation limit (\code{corlimit}). With the 
#'   correlated words now identified, the function identifies dates listed in 
#'   the date column and sums the number of documents associated with the 
#'   identified \code{keyword} and all other correlated words, generating a line
#'   plot to represent the findings for each. These line plots are then layered 
#'   on top of each other for comparison purposes. This output is useful in 
#'   highlighting increases in document production for correlated terms in
#'   reference to a specific word. It illustrates how different words are used
#'   more/less over the course of time.
#' @param data.td A tidy dataset
#' @param term A user defined term, or vector of terms.
#' @param corlimit A user defined numeric correlation limit between 0 and 1
#' @return Time series line plot of words associated with \code{term}
#' @export
#' @import tidytext tm dplyr ggplot2 scales 
#' @examples
#' \donttest{ 
#' word.Assocs(Articles, "hurricane", .6)
#' word.Assocs(Articles, c("hurricane","tornado"), .75)
#' }
#' 
#' 
####Word Associations####
word.Assocs<- function(data.td, term, corlimit){
  `%>%` <- dplyr::`%>%`
  # term <- quo(term)
  text<- quo(text)
  ArticleNo <- quo(ArticleNo)
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  #is character
  if(!is.character(term)) stop('The term needs to be a character vector')
  if(grepl(" ",term)) stop('Term must be a single token. No spaces')
  
  if(length(corlimit)!=1 | !is.numeric(corlimit) | corlimit >1 | corlimit <0) stop('Correlation limit must be a single value between 0 and 1')
  
  data_dtm<-data.td %>%
    unnest_tokens(word,text) %>% 
    filter(!word %in% tidytext::stop_words$word) %>% 
    count(ArticleNo, word, sort = TRUE) %>%
    ungroup() %>% 
    cast_dtm(ArticleNo, word, n)
  # Additional c
  Assoc <- findAssocs(data_dtm, term , corlimit)
  print(Assoc)
  plot_list <- list()
  for(k in 1:length(term)){ 
    
    subject <- as.data.frame(Assoc[k]) %>% 
      rownames()
    
    daterng <-as.Date(c(min(data.td$date),max(data.td$date)))
    
    p <- list()
    for(i in 1:length(subject)){
      
      p[[i]]<-data.td %>%
        filter(grepl(pattern = subject[i],x = data.td$text, ignore.case =T)) %>%
        mutate(date=as.Date(date),term =subject[i]) %>%
        group_by(date) %>%
        summarise(n = n()) %>%
        mutate(term=rep(subject[i]))
    }
    p = do.call(rbind,p)
    
    plot <- ggplot(p, aes(x = date, y = n, colour = term, group=term))+
      geom_line()+
      geom_point()+
      scale_x_date(breaks= scales::date_breaks(width= "1 day"),
                   labels = scales::date_format("%b-%d"),
                   limits = c(daterng[1], daterng[2]))+
      theme(axis.text.x=element_text(size=10,angle=60))+
      theme(legend.text=element_text(size=16))+
      labs(x="Date",y="Frequency")+
      ggtitle(label=paste0("Co-occurence of Terms Associated with: ",term[k]),subtitle = paste0("Correlation = ",corlimit))
    plot_list[[k]] = plot
    print(plot_list)
  }
  
}
