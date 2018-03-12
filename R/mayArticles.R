#'  May 2017 News Articles
#' 
#'  An unclean dataset containing 21,270 news articles from nine recognized news
#'  sources collected between 01 - 31 May 2017. This dataset requires the use of
#'  the 'corpusPrep' function before it will work properly with remaining
#'  functions in this package. The variables are as follows:
#'    
#'  \describe{ 
#'    \item{Title}{The title of each news article} 
#'    \item{Author}{Identifies the
#'    author of each news article. Unidentified authors are represented by
#'    "unknown" } 
#'    \item{Date}{Publication date of each news article given in the
#'    "YYYYMMDD HH:MM:SS" format} 
#'    \item{URL}{Weblink to each news article} 
#'    \item{NewsSource}{Represents the name of the news source where each
#'    article was published} 
#'    \item{Text}{Text from each news article} 
#'    \item{ArticleNo}{Sequential list of each article in the dataset} }
#'    
"mayArticles"
