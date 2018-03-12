#' @title Transform, merge, separate, or delete terms from a corpus
#' @description Manipulate the content of text that will be analyzed. Merge like terms into a single term, replace names
#'   found in text, and remove content deemed irrelevant.
#' @details Supplied a search term and a replacement term, this function seeks 
#'   to identify each instance of the search term within the corpus and replace 
#'   it with the replacement term. Should the user elect to delete a term, instead of replacing it, the 
#'   replacement term should be identified as "" within the function. **Warning: 
#'   Once a term is deleted from the corpus it can not be replaced. To return
#'   the term to the analysis, the corpus must be rebuilt to its previous state.
#' @param data.td A tidy dataset
#' @param term A user identified term
#' @param term.replacement A user specified term to replace the original term found in the text
#' @return Permanently alters the corpus by replacing all instances of \code{term} with \code{term.replacement}
#' @export
#' @import dplyr rlang
#' @examples 
#' \donttest{
#' Articles <- mergeTerms(Articles,"Affordable Care Act","ACA")
#' Articles <- mergeTerms(Articles,"White House", "White_House")
#' Articles <- mergeTerms(Articles, "Fox News", "")
#' }


###########MERGE TERMS FUNCTION###################
mergeTerms<-function(data.td,term,term.replacement){
  `%>%` <- dplyr::`%>%`
  # term <- quo(term)
  # term.replacement <- quo(term.replacement)
  #Error checking performs check of data class
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  #is character
  if(!is.character(term)) stop('The term needs to be a character vector')
  if(!is.character(term.replacement)) stop('The term needs to be a character vector')
  
  for(i in 1: length(data.td$text)){
    # i<-7
    # data.td$text[[i]]
    data.td[i,"text"]<-data.td[i,"text"] %>% gsub(pattern=as.character(term),
                                                  replacement=as.character(term.replacement),
                                                  ignore.case = T)
    
  }
  data.td <-data.td
}
