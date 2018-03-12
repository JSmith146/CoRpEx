#' @title Time series plot of document frequency 
#' @description Produces a time series plot of the frequency of documents within a
#'   corpus by publication date.
#' @details This function first identifies dates listed in the date column. It 
#'   then sums the number of documents associated with each identified calendar 
#'   date and generates a line plot for visual representation of these findings.
#'   This output is useful in highlighting increases in document production, 
#'   which may identify blocks of time in which interesting events may have
#'   occurred. Using the 'iso.date' function, these observed increases can be
#'   converted into subset corpuses used for further analysis.
#' @param data.td A tidy dataset
#' @return Time series line plot of documents in \code{data.td} by day
#' @export
#' @import dplyr ggplot2 scales rlang

#################Corp Plot###########################

corp.plot <- function(data.td){
  `%>%` <- dplyr::`%>%`
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  
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
