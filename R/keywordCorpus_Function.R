#' @title Create a subcorpus based on a user specified keyword
#' @description Create a reduced subcorpus of documents which contain a specified keyword.
#' @details This function will create a new subcorpus of documents, from the
#'   original corpus,  in which each document contains the user specified
#'   \code{keyword}. All other documents will be excluded from this subcorpus.
#' @param data.td A tidy dataset
#' @param keyword A user specified keyword
#' @return Creates a subcorpus with only documents containing \code{keyword}
#' @export
#' @import dplyr
#' @examples
#' \donttest{
#' hurricane <- keyword.corpus(Articles, "hurricane")
#' }
 


keyword.corpus<- function(data.td,keyword){
  `%>%` <- dplyr::`%>%`
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  #is character
  if(!is.character(keyword)) stop('The term needs to be a character vector')
  
  if(grepl(" ",keyword)) stop('Term must be a single token. No spaces')
  
  sub.topic <- data.td %>% 
    dplyr::filter(grepl(pattern = keyword,x = data.td$text, ignore.case =T)) 
  
  return(sub.topic)
}
