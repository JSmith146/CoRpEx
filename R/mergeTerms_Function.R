#' @title User can choose to either transform, merge, separate, or delete terms from a corpus
#' @description description
#' @param data.td A tidy dataset
#' @param term A user identified term
#' @param term.replacement A user specified term to replace the original term found in the text
#' @return Permanently alters the corpus by replacing all instances of \code{term} with \code{term.replacement}
#' @export


###########MERGE TERMS FUNCTION###################
mergeTerms<-function(data.td,term,term.replacement){
  term <- quo(term)
  term.replacement <- quo(term.replacement)
  #Error checking performs check of data class
  if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  #is character
  if(!is.character(term)) stop('The term needs to be a character vector')
  if(!is.character(term.replacement)) stop('The term needs to be a character vector')
  if(grepl(" ",term)) stop('Term must be a single token. No spaces')
  
  for(i in 1: length(data.td$text)){
    # i<-7
    # data.td$text[[i]]
    data.td[i,"text"]<-data.td[i,"text"] %>% gsub(pattern=as.character(term),
                                                  replacement=as.character(term.replacement),
                                                  ignore.case = T)
    
  }
  data.td <-data.td
}
