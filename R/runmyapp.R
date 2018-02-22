#' @title Runs an app in my package
#' 
#' @description Runs as shiny app
#'  
#' @param app_name Character string for a directory in this package
#' @param ...      Additional options passed to shinyApp
#' @return A printed shiny app
#' @importFrom shiny shinyAppDir runApp
#' @export

runmyapp <- function(app_name,...){

  app_dir <-system.file('apps', app_name, package = 'CoRpEx')

  shiny::shinyAppDir(app_dir=app_dir, options = list(...))

}

#Creating a roxygen header which will become the documentation file
# Using "..." makes for an easier way to pass unnamed documents to a function
# Any function that you export you need to document it
# To add data to the package devtools::use_data(mtcars)

