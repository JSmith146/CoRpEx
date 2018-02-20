#' @title Creates a subcorpus based on user specified date ranges
#' @description description
#' @param data.td A tidy dataset
#' @param Beg.date User specified beginning date 
#' @param End.date User specified end date
#' @return Creates a subcorpus containing only documents produced between \code{Beg.date} and \code{End.date}
#' @export


#############Iso.Dates######################
#This function will create a subset of topics based on identified date ranges
iso.date<- function(data.td,Beg.date,End.date){
  #Error checking performs check of data class
  if(class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')
  if(!class(data.td$date) %in% "Date") stop('Data in the "date" column is not in the correct form \n Data must be of class "Date"')
  
  date.type <- c("%d%b%Y","%d%B%Y","%m-%d-%Y","%d-%m-%Y","%Y-%m-%d")
  B.date <- Beg.date
  E.date <- End.date
  
  B.date <- as.Date(B.date,"%d%B%Y")
  i<-1
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
  i<-1
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
  


