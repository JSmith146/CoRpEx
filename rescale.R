ratio <- function(x,y,digits){
  return(round(x/y,digits))
  
}
library(purrr)
rescale <-function(x,digits=2,na.rm=TRUE){
  if(class(x)%in% 'data.frame') message("Warning:\n You're the worst.\n Just stop.\n Object must be a vector")
  if(isTRUE(na.rm))x<-na.omit(x)
  rng<-range(x)
  scaled<-(x-rng[1])/(rng[2] -rng[1])
  round(scaled, digits=digits)
}

set.seed(123)
vec1 = runif(10,min=5,max=13)
# x<-vec1
rescale(vec1)

data<-mtcars

sapply(mtcars,rescale)
mtcars %>% 
  map_df(rescale)

sapply(mtcars[,1], rescale)
vec2<- mtcars[,1]
rescale(vec2)
rescale(mtcars)
class(mtcars)
class(vec2)
