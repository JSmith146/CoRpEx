#' @title Produces a time series plot of the frequency of articles, containing a user specified keyword, within a corpus by date
#' @description description
#' @param data.td A tidy dataset
#' @param keyword A user defined keyword
#' @return Time series line plot of documents in \code{data.td}  which contain \code{keyword} by day
#' @export
#' @import dplyr ggplot2 scales


####################KEYWORD SEARCH###############################
kwsearch<-function(data.td,keyword){
  
  if(class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  if(!class(data.td$date) %in% "Date") stop('Data in the "date" column is not in the correct form \n Data must be of class "Date"')
  if(!is.character(keyword)) stop('The term needs to be a character vector')
  if(grepl(" ",keyword)) stop('Term must be a single token. No spaces')
  
  daterng <-as.Date(c(min(data.td$date),max(data.td$date)))
  
  data.td %>% 
    filter(grepl(pattern = keyword,x =~text, ignore.case =T)) %>% 
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