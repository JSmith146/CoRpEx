CorpEx
================
Jeffrey Smith
23 March 2018

[![Build Status](https://travis-ci.org/JSmith146/CoRpEx.svg?branch=master)](https://travis-ci.org/JSmith146/CoRpEx) [![CircleCI](https://circleci.com/gh/JSmith146/CoRpEx.svg?style=svg)](https://circleci.com/gh/JSmith146/CoRpEx) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/JSmith146/CoRpEx?branch=master&svg=true)](https://ci.appveyor.com/project/JSmith146/CoRpEx)

<!--don't edit README.md go to README.Rmd instead-->
Section 1 - Basic Information
=============================

1.1 Name: CorpEx
----------------

1.2 Summary:
------------

CorpEx is a package designed for the exploration and mining of large textual corpuses of documents.

1.3 Description
---------------

The CorpEx package is designed for novice R users who require the ability to manuever through large corpuses of textual documents to discover contextual insight. This package will provide users with the ability to effectively and efficiently explore these large textual data corpuses through the utilization of various exploratory text mining techniques. Techniques used in this package consist of methods to visualize components of a corpus (corp plot and keyword search), methods to reduce and specfiy the size of the corpus (topic subset and date isolation), methods to manipulate the content of the corpus (merge terms), and methods to provide visualizations of text mining analysis (term association, topic modeling, n-gram analysis, and bigram and correlation network analysis). T Implementation of this package will require that users have a robust data frame in which, at a minimum, columns are identified for the document Id, date, and text data.

Users will have the ability to explore corpuses through the application of various text mining statistical techniques such as n-gram analysis, term frequency analysis, term correlation analysis, and topic modeling. This package will build upon multiple existing R text mining packages including `tm`, `topicmodels`, `quanteda`, and `ldatuning` to name a few. Other packages used in this package provide functionality for data structure, i.e. `tidyr`, and base level code used for execution, i.e. `tidyverse`, `widyr`,and `tidytext`. Visualization packages used include `ggplot`, `igraph`, and `ggraph`.

1.4 Access
----------

Users will access this analytic product through either the use of impletementing the package or through the use of the online R shiny application.

1.5 Security Concerns
---------------------

Users will upload their own corpuses. Any security concerns will be the reponsibilty of the user who uploaded data.

1.6 Design Constraints
----------------------

This package requires no appearance/design constraints

<table>
<colgroup>
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
<col width="12%" />
</colgroup>
<thead>
<tr class="header">
<th>Rank</th>
<th>Feature</th>
<th>Status</th>
<th>Description</th>
<th>Values</th>
<th>Inputs</th>
<th>Outputs</th>
<th>Use</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>Topic Subset</td>
<td>Complete</td>
<td>Allows the user to create an independent sub-corpus based on a keyword</td>
<td>Users can reduce the size of the corpus based on information relevant to their research</td>
<td>Corpus name, Keyword, New corpus name</td>
<td>Creates a new sub-corpus from the original corpus containing only the documents that contain a specified key word.</td>
<td>Users will isolate only relevant documents for the continuation of their analysis</td>
</tr>
<tr class="even">
<td>2</td>
<td>Isolate Dates</td>
<td>Complete</td>
<td>Allows the user to create an independent sub-corpus based on a date range</td>
<td>Users can reduce the size of the corpus based on information relevant to their research</td>
<td>Corpus name, Start date, End date</td>
<td>Creates a new sub-corpus from the original corpus containing only the documents within the date ranges.</td>
<td>Users will isolate only relevant documents for the continuation of their analysis</td>
</tr>
<tr class="odd">
<td>3</td>
<td>Merge Terms</td>
<td>Complete</td>
<td>Allows the user to create, merge, and delete terms within a corpus</td>
<td>Users can apply subject matter expertise to and remove noisy data from their analysis</td>
<td>Corpus name, Term, Replacement term</td>
<td>Changes the content of the current corpus, updating it with the information provided by the user.</td>
<td>Users will apply custom information to the corpus based on subject matter or organizational information, and also remove noisy terms from the dataset.</td>
</tr>
<tr class="even">
<td>4</td>
<td>Print N-grams</td>
<td>Complete</td>
<td>Allows users to perform n-gram analysis on a corpus</td>
<td>Users can navigate through varying n-grams to gain insight into the content of a corpus. Also, this plot provides a starting point to implement the merge terms function.</td>
<td>Corpus name, N-gram, Number of terms to include (n)</td>
<td>Creates an inverted bar chart with the top n most frequent n-grams identified</td>
<td>Users will be able to infer the content of the corpus and identify terms that need to be created, merged, or deleted.</td>
</tr>
<tr class="odd">
<td>5</td>
<td>Bigram Network</td>
<td>Complete</td>
<td>Performs network analysis on the most frequent bigrams found within a corpus</td>
<td>Provides a visualization of bigram connections to allow the user to make inferences into the data.</td>
<td>Corpus name, Frequency threshold</td>
<td>Network graph visualization connecting words (nodes) based on the frequency of their occurrence next to each other (edges)</td>
<td>Users will make inferences into the data based on this information</td>
</tr>
<tr class="even">
<td>6</td>
<td>Correlation Network</td>
<td>Complete</td>
<td>Performs network analysis on the most frequently correlated terms found within a corpus</td>
<td>Provides a visualization of correlated words found in a corpus to allow the user to make inferences into the data.</td>
<td>Corpus name, Correlation threshold</td>
<td>Network graph visualization connecting words (nodes) based on their correlation to one another (edges)</td>
<td>Users will make inferences into the data based on this information</td>
</tr>
<tr class="odd">
<td>7</td>
<td>Topic Number</td>
<td>Complete</td>
<td>Provides the user with an estimate for the number of hidden topics within a corpus</td>
<td>Presents the user with an expected number of k topics to use in the topic modeling analysis.</td>
<td>Corpus name</td>
<td>Maximization and minimization plots (ldatuning) of the estimated number of topics found within a corpus</td>
<td>Users will determine an expected number of topics to designate in the topic plot function.</td>
</tr>
<tr class="even">
<td>8</td>
<td>Topic Plot</td>
<td>Complete</td>
<td>Creates topic models for a corpus, designating each document within the corpus to a specific topic.</td>
<td>Allows users to create sub-corpuses based on hidden topics found in a corpus.</td>
<td>Corpus name, K topics</td>
<td>Creates topic models for each document within the corpus.</td>
<td>Users can create new corpuses based on hidden topics found in the corpus.</td>
</tr>
<tr class="odd">
<td>9</td>
<td>Term Association</td>
<td>Complete</td>
<td>Identifies words that are correlated with specific, user defined keywords and denotes the frequency of each word as they are mentioned over time.</td>
<td>Identifies words highly related to user defined words of interest to uncover more information in the corpus.</td>
<td>Corpus name, User defined term, Correlation limit (threshold)</td>
<td>Time series line plot of the frequency of documents containing the correlated terms</td>
<td>Used to identify related terms in the analysis that could provide more insight into the data</td>
</tr>
<tr class="even">
<td>10</td>
<td>Corpus Plot</td>
<td>Complete</td>
<td>Allows the user to visualize the frequency of documents produced within a corpus over time.</td>
<td>Users can identify periods in the data where there were fluctuations in the frequency of documents produced.</td>
<td>Corpus name</td>
<td>Time series line plot of all document contained within a corpus.</td>
<td>Used to identify periods where fluctuations in the frequency of documents occur. Users would then isolate the dates in these regions for further study.</td>
</tr>
<tr class="odd">
<td>11</td>
<td>Keyword Search</td>
<td>Complete</td>
<td>Allows the user to visualize the frequency of documents, containing a specific keyword, produced within a corpus over time.</td>
<td>Based on a keyword, users can identify periods in the data where there was a fluctuation in the frequency of documents produced.</td>
<td>Corpus name, User defined term</td>
<td>Time series line plot of all document contained within a corpus that contain a given keyword.</td>
<td>Used to identify periods where fluctuations in the frequency of documents occur, based on a keyword. Users would then isolate the dates in these regions for further study.</td>
</tr>
</tbody>
</table>

There is sufficient time for all features to be included in the current version of this analytic.
