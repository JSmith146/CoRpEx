#' @title Allows the user check and prepare their corpus to be in a usable state for the remainder of the commands
#' @description description
#' @param data.td A tidy dataset
#' @return Returns the same corpus, with appropriate column names, correct column classes, and prepped data
#' @export
#' @import tidyr tm dplyr stringr tidytext
#' @importFrom lubridate ymd_hms ymd mdy dmy 

#Bring in the data
corpusPrep <- function(data.td){

#Error check for correct data class
if(!class(data.td) %in% c("tbl_df","tbl","data.frame")) stop('Data is not in the correct form \n Data must be in a tibble or data frame')

columns<- names(data.td)

for(i in 1:length(columns)){
writeLines(paste('Column Header',i,":",columns[i], sep=" "))
}
# Clean text column

##Identify text column
text_col <- readline("What is the name of the column where your text is found?  ")

###Error check
  while(!text_col %in% columns){
    text_col <- readline("Please enter the correct name of the Column Header in your dataframe.")
  }

text_col <- as.character(unlist(strsplit(text_col, ",")))

text_col_num<-match(text_col,columns)

##Rename text column to "Text"
colnames(data.td)[text_col_num]<- "Text"

##Convert all rows to character
data.td$Text<- unlist(lapply(data.td$Text, as.character))
##Remove all special characters from text
data.td$Text <- stringr::str_replace_all(data.td$Text,'[^([:alnum:]|\\.|\\")]'," ")
##Encode all text within the Text column as "UTF-8"
Encoding(data.td$Text)  <- "UTF-8"
##Remove all "enter" and "tab" sequences in text
data.td$Text <- gsub("\n","",data.td$Text)
data.td$Text <- gsub("\t","",data.td$Text)

# Check for dates
date_info<-readline("Does your data use date/time? Please Enter (Y/N):   ")
while(!date_info %in% c("Y","y","N","n")){
  date_info<-readline("Does your data use date/time? Please Enter (Y/N):   ")
}

# Clean date column

if(date_info=="Y"|date_info=="y"){
   
   ##Identify date column
   date_col <- readline("What is the name of the column where your dates are found?  ")
   ###Error check
   while(!date_col %in% columns){
     date_col <- readline("Please enter the correct name of the Column Header in your dataframe.  ")
   }
   
   date_col <- as.character(unlist(strsplit(date_col, ",")))
   
   date_col_num<-match(date_col,columns)
   ##Rename text column to "Date"
   colnames(data.td)[date_col_num]<- "Date"
   
   #Format Date
   if(!class(data.td$Date[1]) %in% c("Date","POSIXct","POSIXt")){
     ##Convert all rows to character
     data.td$Date<- unlist(lapply(data.td$Date, as.character))
   }
     
     if(!is.na(lubridate::ymd_hms(data.td$Date[1]))){
       
       data.td$Date <- lubridate::ymd_hms(data.td$Date)
       
     }else if (!is.na(lubridate::ymd(data.td$Date[1]))){
       
       data.td$Date <-lubridate::ymd(data.td$Date)
   
     }else if (!is.na(lubridate::mdy(data.td$Date[1]))){
       
       data.td$Date <-lubridate::mdy(data.td$Date)

     }else if (!is.na(lubridate::dmy(data.td$Date[1]))){
       
       data.td$Date <-lubridate::mdy(data.td$Date)

     } else {
        writeLines('Please ensure that dates in your date column follow one of the following formats:\n
       yyyy-mm-dd hh:mm:ss
       yyyymmdd hh:mm:ss
       yyyy-mm-dd
       yyyymmdd
       mm-dd-yyyy
       mmddyyyy
       dd-mm-yyyy
       ddmmyyyy')
        stop()
      }


}else if (date_info=="N"|date_info=="n"){
  writeLines("You will not have access to the following functions:\n word.Assocs()\n kwsearch()\n iso.date()\n corp.plot")
  next()
    }


# Clean/create title column

## Check for titles
title_info<-readline('Does the data frame have titles associtated with each instance? (Y/N):  ')

while(!title_info %in% c("Y","y","N","n")){
  date_info<-readline("Does the data frame have titles associtated with each instance? (Y/N):   ")
}

if(title_info=="Y"|title_info=="y"){
title_col<-readline("What is the name of the column where the titles are found?  ")
###Error check
while(!title_col %in% columns){
  title_col <- readline("Please enter the correct name of the Column Header in your dataframe. ")
}

title_col <- as.character(unlist(strsplit(title_col, ",")))

title_col_num<-match(title_col,columns)
##Rename text column to "Date"
colnames(data.td)[title_col_num]<- "Title"

##Convert all rows to character
data.td$Title<- unlist(lapply(data.td$Title, as.character))

}else if (date_info=="N"|date_info=="n"){
  
    data.td$Title<-rep(NA,dim(data.td)[1])
}

# Clean/create author column

## Check for titles
author_info<-readline('Does the data frame have authors associtated with each instance? (Y/N):  ')

while(!title_info %in% c("Y","y","N","n")){
  author_info<-readline("Does the data frame have authors associtated with each instance? (Y/N):   ")
}

if(author_info=="Y"|author_info=="y"){
  author_col<-readline("What is the name of the column where the author information is found?  ")
  ###Error check
  while(!author_col %in% columns){
    author_col <- readline("Please enter the correct name of the Column Header in your dataframe. ")
  }
  
  author_col <- as.character(unlist(strsplit(author_col, ",")))
  
  author_col_num<-match(title_col,columns)
  
  ##Rename author column to "Author"
  colnames(data.td)[author_col_num]<- "Author"
  
  ##Convert all rows to character
  data.td$Author<- unlist(lapply(data.td$Author, as.character))
  
}else if (author_info=="N"|author_info=="n"){
  
  data.td$Author<-rep(NA,dim(data.td)[1])
}

# Clean/create URL column

## Check for URLs
url_info<-readline('Does the data frame have urls associtated with each instance? (Y/N):  ')

while(!url_info %in% c("Y","y","N","n")){
  url_info<-readline("Does the data frame have urls associtated with each instance? (Y/N):   ")
}

if(url_info=="Y"|url_info=="y"){
  
  url_col<-readline("What is the name of the column where the url information is found?  ")
  
  ###Error check
  while(!url_col %in% columns){
    url_col <- readline("Please enter the correct name of the Column Header in your dataframe. ")
  }
  
  url_col <- as.character(unlist(strsplit(url_col, ",")))
  
  url_col_num<-match(url_col,columns)
  
  ##Rename author column to "URL"
  colnames(data.td)[url_col_num]<- "URL"
  
  ##Convert all rows to character
  data.td$URL<- unlist(lapply(data.td$URL, as.character))
} else if (url_info=="N"|url_info=="n"){
  
  data.td$URL<-rep(NA,dim(data.td)[1])
}

# Clean/create NewsSource column

## Check for NewsSource
newssource_info<-readline('Does the data frame have news sources associtated with each instance? (Y/N):  ')

while(!newssource_info %in% c("Y","y","N","n")){
  newssource_info<-readline("Does the data frame have news sources associtated with each instance? (Y/N):   ")
}

if(newssource_info=="Y"|newssource_info=="y"){
  newssource_col<-readline("What is the name of the column where the news source information is found?  ")
  
  ###Error check
  while(!newssource_col %in% columns){
    newssource_col <- readline("Please enter the correct name of the Column Header in your dataframe. ")
  }
  
  newssource_col <- as.character(unlist(strsplit(newssource_col, ",")))
  
  newssource_col_num<-match(newssource_col,columns)
  ##Rename author column to "URL"
  colnames(data.td)[newssource_col_num]<- "URL"
  
  ##Convert all rows to character
  data.td$NewsSource<- unlist(lapply(data.td$NewsSource, as.character))
}else if (newssource_info=="N"|newssource_info=="n"){
  
  data.td$NewsSource<-rep(NA,dim(data.td)[1])
}

# Clean/create ID Number column

## Check for ID Numbers
articleno_info<-readline('Does the data frame have identifiers associtated with each instance? (Y/N):  ')

while(!articleno_info %in% c("Y","y","N","n")){
  articleno_info<-readline("Does the data frame have identifiers associtated with each instance? (Y/N):   ")
}

if(articleno_info=="Y"|articleno_info=="y"){
  articleno_col<-readline("What is the name of the column where the identifier information is found?  ")
  
  ###Error check
  while(!articleno_col %in% columns){
    articleno_col <- readline("Please enter the correct name of the Column Header in your dataframe. ")
  }
  
  articleno_col <- as.character(unlist(strsplit(articleno_col, ",")))
  
  articleno_col_num<-match(articleno_col,columns)
  
  ##Rename ID column to "ArticleNo"
  colnames(data.td)[articleno_col_num]<- "ArticleNo"
  
  ##Convert all rows to integer
  data.td$ArticleNo<- unlist(lapply(data.td$ArticleNo, as.integer))
  
}else if (articleno_info=="N"|articleno_info=="n"){
  
  data.td$ArticleNo<-test3<-seq(dim(data.td)[1])
  data.td$ArticleNo<- unlist(lapply(data.td$ArticleNo, as.integer))
}


# Create custom_reader map
custom_reader <- tm::readTabular(
  mapping = list(title = "Title",author = "Author",
                 date = "Date", url = "URL", source = "NewsSource",
                 content = "Text", id = "ArticleNo"))
# Convert dataframe to corpus
data.corpus <- tm::VCorpus(
  tm::DataframeSource(data.td), 
  readerControl = list(reader = custom_reader))

data.td<-tidytext::tidy(data.corpus) 

return(data.td)
}

