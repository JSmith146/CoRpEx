#' @title Produces a time series plot of terms associated with a user defined word up to a specified correlation limit
#' @description description
#' @param data.td A tidy dataset
#' @param term A user defined character vector containing no spaces
#' @param corlimit A user defined numeric correlation limit between 0 and 1
#' @return Time series line plot of words associated with \code{term}
#' @export
#' @import tidytext tm dplyr ggplot2 scales

####Word Associations####
word.Assocs<- function(data.td, term, corlimit){
  
  term <- quo(term)
  #Error checking performs check of data class
  if(class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  #is character
  if(!is.character(term)) stop('The term needs to be a character vector')
  if(grepl(" ",term)) stop('Term must be a single token. No spaces')
  
  if(length(corlimit)!=1 | !is.numeric(corlimit) | corlimit >1 | corlimit <0) stop('Correlation limit must be a single value between 0 and 1')
  
  data_dtm<-data.td %>%
    unnest_tokens_(~word, ~text) %>% 
    filter_(!~word %in% tidytext::stop_words$word) %>% 
    count_(~ArticleNo, ~word, sort = TRUE) %>%
    ungroup() %>% 
    cast_dtm_(~ArticleNo, ~word, n)
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
        filter_(grepl(pattern = subject[i],x = ~text, ignore.case =T)) %>%
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
      labs(x="Date",y="Frequency")+
      ggtitle(label=paste0("Co-occurence of Terms Associated with: ",term[k]),subtitle = paste0("Correlation = ",corlimit))
    plot_list[[k]] = plot
    print(plot_list)
  }
  
}
