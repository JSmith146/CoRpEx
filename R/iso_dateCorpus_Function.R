#' @title Create a subcorpus based on user specified date ranges
#' @description Create a reduced subcorpus containing documents produces within
#'   a defined date range.
#' @details This function establishes \code{Beg.date} as the beginning date and 
#'   \code{End.date} as the ending date. It then identifies all rows of data 
#'   whose associated dates fall on or between these dates. These identified
#'   rows of data within the corpus are then used to create a new subcorpus.
#' @param data.td A tidy dataset
#' @param Beg.date User specified beginning date 
#' @param End.date User specified end date
#' @details 
#' \describe{ 
#'    \item{Date Formats}{Dates must be input in one of the following formats:}
#'    \item{}{"6aug2005"}
#'    \item{}{"6august2005"}
#'    \item{}{"08-06-2005"}
#'    \item{}{"06-08-2005"}
#'    \item{}{"2006-08-06" }}
#' @return Creates a subcorpus containing only documents produced between \code{Beg.date} and \code{End.date}
#' @export
#' @examples
#' \donttest{
#' Subcorpus <- iso.date(Articles, "12may2017","19may2017")
#' Subcorpus <- iso.date(Articles, "12-05-2017","19-05-2017")
#' }
#############Iso.Dates######################

iso.date<- function(data.td,Beg.date,End.date){
  #Error checking 
  if(as.logical(sum(class(data.td) %in% c("tbl_df","tbl","data.frame")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  if(as.logical(sum(class(data.td$date) %in% c("Date","POSIXct","POSIXt")==0))) stop('Data is not in the correct form Data must be in a tibble or data frame')
  #Function start
  date.type <- c("%d%b%Y","%d%B%Y","%m-%d-%Y","%d-%m-%Y","%Y-%m-%d")
  B.date <- Beg.date
  E.date <- End.date
  B.date <- as.Date(B.date,"%d%B%Y")
  
  if(is.na(B.date)){
    for(i in 1:length(date.type)){
      B.date <- as.Date(Beg.date,date.type[i])
      if(!is.na(B.date)){
        B.date<-B.date
      }
    }
  if(is.na(B.date))
    stop('Please use one of the following date input methods:\n 
         "6aug2005"\n 
         "6august2005"\n 
         "08-06-2005"\n
         "06-08-2005"\n
         "2006-08-06"\n')
    }
  
  E.date <- as.Date(E.date,"%d%B%Y")
 
  if(is.na(E.date)){
    for(i in 1:length(date.type)){
      E.date <- as.Date(End.date,date.type[i])
      if(!is.na(E.date)){
        E.date<-E.date
      }
    }
    if(is.na(E.date))
      stop('Please use one of the following date input methods:\n 
           "6aug2005"\n 
           "6august2005"\n 
           "08-06-2005"\n
           "06-08-2005"\n
           "2006-08-06"\n')
  }
  
  
if(B.date > E.date) stop('Enter Date order correctly. Be sure that beginning date occurs before end date')
  
  data.td$date <-  as.Date(data.td$date)
  
  subcorp<- subset(data.td, date>= B.date & date <= E.date) 
  
  return(subcorp)
  }
  


