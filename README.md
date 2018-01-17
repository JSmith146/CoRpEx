CoRpEx
================
Jeffrey Smith
17 January 2018

<!--don't edit README.md go to README.Rmd instead-->
    ## Loading required package: rJava

    ## Loading required package: xlsxjars

Section 1 - Basic Information
=============================

1.1 Name: CoRpEx
----------------

1.2 Summary:
------------

CoRpEx is a package designed for the exploration and mining of large textual corpuses of documents.

1.3
---

The CoRpEx package is designed for novice R users who require the ability to manuever through large corpuses of textual documents. This package will provide users with the ability to effectively and efficiently explore these large textual data corpuses through the utilization of various exploratory text mining techniques. This package will also allow users the ability to manipulate the content of the corpus by creating, merging, separating, and deleting terms found within a corpus. Additionally, this package will provide visualizations to users during their exploratory navigation through each corpus. Implementation of this package will require that users have a robust data frame with, at a minimum, columns identified for the document Id, date, and text data.

Users will have the ability to explore corpuses through the application of various text mining statistical techniques such as n-gram analysis, term frequency analysis, term correlation analysis, and topic modeling. This package will build upon multiple existing R text mining packages including `tm`, `topicmodels`, `quanteda`, and `ldatuning` to name a few. Other packages used in this package provide functionality for data structure, i.e. `tidyr`, and base level code used for execution, i.e. `tidyverse`, `widyr`,and `tidytext`. Visualization packages used include `ggplot`, `igraph`, and `ggraph`.

1.4
---

Users will access this analytic product through either the use of impletementing the package or through the use of the online R shiny application.

1.5
---

Users will upload their own corpuses. Any security concerns will be the reponsibilty of the user who uploaded data.

1.6
---

This package requires no appearance/design constraints

``` r
# my_data <- read.xlsx2("Info_Table.xlsx", sheetIndex=1, header= TRUE) 
# my_data <- read_excel("Info_Table.xlsx")
# print(my_data)
```
