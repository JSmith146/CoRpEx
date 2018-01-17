install.packages(c("devtools", "roxygen2","testthat","knitr"))
install.packages("devtools")
library("devtools")
library("roxygen2")
library("testthat")
library("knitr")
devtools::find_rtools()
devtools::has_devel()


devtools::create('~/pack1')
browseURL('~')

utils::package.skeleton()
#Package that refers to R C++ (Rcpp)
Rcpp::Rcpp.package.skeleton(name='CoRpEx', path = '~')

browseURL(system.file('DESCRIPTION', package = 'survival'))

rmarkdown::
  
  browseURL(system.file('NAMESPACE', package = 'ggplot2'))
