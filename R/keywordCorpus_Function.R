#' @title Creates a subcorpus based on a user defined keyword
#' @description description
#' @param data.td A tidy dataset
#' @param keyword A user defined keyword
#' @return Creates a subcorpus with only documents containing \code{keyword}
#' @export
#' @import dplyr

keyword.corpus<- function(data.td,keyword){ 
  
  keyword<- quo(keyword)
  #Error checking performs check of data class
  if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  #is character
  if(!is.character(keyword)) stop('The term needs to be a character vector')
  if(grepl(" ",keyword)) stop('Term must be a single token. No spaces')
  
  sub.topic <- data.td %>% 
    filter(grepl(pattern = keyword,x = ~text, ignore.case =T)) 
  
  return(sub.topic)
}
