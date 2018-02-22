#' @title Produces a time series plot of the frequency of articles within a corpus by date
#' @description description
#' @param data.td A tidy dataset
#' @return Time series line plot of documents in \code{data.td} by day
#' @export
#' @import dplyr ggplot2 scales

#################Corp Plot###########################

corp.plot <- function(data.td){
  #Error checking performs check of data class
  if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  
  daterng <-as.Date(c(min(data.td$date),max(data.td$date)))
  
  data.td %>% 
    mutate(date=as.Date(date)) %>%
    group_by(date) %>% 
    summarise(n = n()) %>% 
    ggplot(aes(x=date, y=n))+
    geom_line()+
    geom_point()+
    scale_x_date(breaks= date_breaks(width= "1 day"),
                 labels = date_format("%b-%d-%y"),
                 limits = c(daterng[1], daterng[2]))+
    theme(axis.text.x=element_text(size=6,angle=90))+
    ggtitle(paste0("Frequency of Documents per Day"))+
    labs(x = "dates", y = "frequency")
  
}
