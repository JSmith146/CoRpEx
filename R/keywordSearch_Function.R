#' @title Time series line plot of the frequency of documents containing a user specified keyword
#' @description Produces a time series plot of the frequency of documents within a
#'   corpus containing a specified keyword. Points are delineated by publication date.
#' @details This function first identifies each document which contains the user
#'   specified \code{keyword} and omits all those which do not. It then
#'   identifies dates listed in the date column and sums the number of documents
#'   associated with each identified calendar date, generating a line plot to
#'   represent these findings. This output is useful in highlighting increases
#'   in document production surrounding a specific topic, which may identify
#'   blocks of time in which interesting events may have occurred. Using the
#'   'iso.date' function, these observed increases can be converted into subset
#'   corpuses used for further analysis.
#' @param data.td A tidy dataset
#' @param keyword A user defined keyword
#' @return Time series line plot of documents in \code{data.td} which contain \code{keyword} by day
#' @export
#' @import dplyr ggplot2 scales
#' @examples
#' \donttest{
#' kwsearch(Articles,"hurricane")
#' } 

####################KEYWORD SEARCH###############################
kwsearch<-function(data.td,keyword){
  `%>%` <- dplyr::`%>%`
  #Error checking
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  if(as.logical(sum(class(data.td$date) %in% c("Date","POSIXct","POSIXt")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame') 
  if(!is.character(keyword)) stop('The term needs to be a character vector')
  if(grepl(" ",keyword)) stop('Term must be a single token. No spaces')
  #Function start
  daterng <-as.Date(c(min(data.td$date),max(data.td$date)))
  
  data.td %>% 
    filter(grepl(pattern = keyword,x =data.td$text, ignore.case =T)) %>% 
    mutate(date=as.Date(date)) %>%
    group_by(date) %>% 
    summarise(n = n()) %>% 
    ggplot(aes(x=date, y=n))+
    geom_line()+
    geom_point()+
    scale_x_date(breaks= date_breaks(width= "1 day"),
                 labels = date_format("%b-%d"),
                 limits = c(daterng[1], daterng[2]))+
    theme(axis.text.x=element_text(size=7,angle=60))+
    ggtitle(paste0("Keyword: ",keyword))+
    labs(x = "Date", y = "Frequency")
}
