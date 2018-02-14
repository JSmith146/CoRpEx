# Building my first shiny app
install.packages("choroplethr")
install.packages("choroplethrMaps")
install.packages("shinythemes")
install.packages("htmlTable")
# library(choroplethr)
# library(choroplethrMaps)
# library(shiny)
# library(shinythemes)
# Locate the directory
setwd("C:/Users/El Jefe/Documents/Learning R/CoRpEx/inst/apps")
#Created the directory for this application
  # dir.create("C:/Users/El Jefe/Documents/Learning R/CoRpEx/inst/apps/myfirstApp")
# For each application you will need to create 3 script files and input them into the application folder
  ##global.R
  ##ui.R
  ##server.R

# Create a new Shiny App from the "File" dropdown menu.
# Create them all as at least two different files
# There are ways to get apps into R Markdown files
# When you initiate the shinyApp() it will create an environment for the application to live in



# You want to be sure to apply paired functions (plotOutput and renderPlot) --> ___Output = render____
# Linkning Git to Shiny.io (Username: JSmith146)

install.packages('rsconnect')


#Reactive Values