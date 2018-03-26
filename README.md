CorpEx
================
Jeffrey Smith
26 March 2018

Corpus Exploration (CorpEx)
===========================

A package designed for the exploration and mining of large textual corpuses of documents.

[![Build Status](https://travis-ci.org/JSmith146/CoRpEx.svg?branch=master)](https://travis-ci.org/JSmith146/CoRpEx) [![CircleCI](https://circleci.com/gh/JSmith146/CoRpEx.svg?style=svg)](https://circleci.com/gh/JSmith146/CoRpEx) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JSmith146/CoRpEx?branch=master&svg=true)](https://ci.appveyor.com/project/JSmith146/CoRpEx)

<!--don't edit README.md go to README.Rmd instead-->
Installation
------------

Install the development version of the CorpEx with the following:

``` r
install.packages("devtools")
devtools::install_github("JSmith146/CoRpEx")
```

CorpEx
======

The CorpEx package is designed for novice R users who require the ability to maneuver through large corpuses of textual documents to discover contextual insight. This package will provide users with the ability to effectively and efficiently explore these large textual data corpuses through the utilization of various exploratory text mining techniques. Users will have the ability to explore corpuses through the application of various text mining statistical techniques such as n-gram analysis, term frequency analysis, term correlation analysis, and topic modeling. This package will build upon multiple existing R text mining packages including `tm`, `topicmodels`, `quanteda`, and `ldatuning` to name a few. Other packages used in this package provide functionality for data structure, i.e. `tidyr`, and base level code used for execution, i.e. `tidyverse`, `widyr`,and `tidytext`. Visualization packages used include `ggplot`, `igraph`, and `ggraph`.

Using CorpEx
------------

![CorpEx Methodology](./man/figures/static/CorpEx%20Methodology.png)

The CorpEx methodology focuses on three different phases that users can implement iteratively throughout the course of their exploration. Techniques used in this package consist of methods to visualize components of a corpus (corp plot and keyword search), methods to reduce and specify the size of the corpus (topic subset and date isolation), methods to manipulate the content of the corpus (merge terms), and methods to provide visualizations of text mining analysis (term association, topic modeling, n-gram analysis, and bigram and correlation network analysis). Implementation of this package will require that users have a robust data frame in which, at a minimum, columns are identified for the document Id, date, and text data.

User Exploration Phase
----------------------

This phase provides the user the functionality to explore the dataset to obtain any preliminary insight that is to be gained.

-   `keyword.corpus()`

    Allows the user to create an independent sub-corpus by isolating only relevant documents which contain a specified keyword. Users can reduce the size of the corpus based on information relevant to their specific research.

-   `iso.date()`

    Allows the user to create an independent sub-corpus by isolating only relevant documents produced within a specified date range.

-   `ngram.print()`

    Allows users to navigate various n-grams to gain insight into the content of a corpus. This feature creates an inverted bar chart identifying the top *n* most frequent n-grams. This feature also provides a starting point to implement the merge terms function. Ultimately, users will be able to infer the content of the corpus and identify terms that need to be created, merged, or deleted.

-   `corp.plot()`

    Allows the user to visualize the frequency of documents produced within a corpus over time. This feature produces a time series line plot of all document contained within a corpus based on each document's provided publication date.Useful to identify periods where fluctuations in the frequency of documents occur.

-   `kwsearch()`

    Allows the user to visualize the frequency of documents, containing a specific keyword, produced within a corpus over time. This feature provides a time series line plot of all document contained within a corpus that also contain a given keyword.

-   `word.Assocs()`

    Identifies words that are correlated with specific, user defined keywords and denotes the frequency of each word as they are mentioned over time. This feature provides a time series line plot of the frequency of documents containing the correlated terms.

User Defined Manipulation (UDM) Phase
-------------------------------------

This phase provides users the ability to manipulate the content of the corpus being explored.This allows for subject matter expertise or organizationally recognized information to be implemented directly into the analysis.

-   `merge.terms()`

    Allows the user to create, merge, and delete terms within a corpus based on subject matter or organizational information. This also removes noisy terms from the dataset and reduces potential skewing. This feature works well when used in conjunction with `ngram.print`.

Analysis Phase
--------------

-   `bigram.network()`

    Performs network analysis on the most frequent bigrams found within a corpus and provides a visualization of bigram connections to allow the user to make inferences into the data.

-   `cor.network()`

    Performs network analysis on the most frequently correlated terms found within a corpus and provides a visualization of correlated words found in a corpus to allow the user to make inferences into the data.

-   `topic.number()`

    Presents the user with an expected number of *k* topics to use in topic modeling analysis. This feature uses the `ldatuning` package and outputs maximization and minimization plots of the estimated number of topics found within a corpus.

-   `topic.models()`

    Allows users to discover latent topic models within a corpus, and assign a topic number to each document within a corpus. This feature uses the Latent Dirichlet Allocation (LDA) technique from the the `topicmodels` package.
