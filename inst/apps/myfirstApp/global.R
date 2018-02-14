#Use with myfirstApp
# Put all of the calls to other packages and data that may be needed in here
# define created functions here if they are not in a package
# install.packages("choroplethr")
# install.packages("choroplethrMaps")

# 646 RM 205
library(choroplethr)
library(choroplethrMaps)
library(shiny)
library(shinythemes)

data('df_state_demographics')
map_data <- df_state_demographics