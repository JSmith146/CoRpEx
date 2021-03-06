% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/printNgrams_Function.R
\name{ngram.print}
\alias{ngram.print}
\title{Inverted bar graph of the most frequent n-grams found within a corpus}
\usage{
ngram.print(data.td, ngram = 1, num = 15)
}
\arguments{
\item{data.td}{A tidy dataset}

\item{ngram}{A user defined integer representing the number of tokens to analyze, 'n'}

\item{num}{A user definied number of most frequenct ngrams to plot in the bar graph}
}
\value{
A bar graph of the most frequent \code{ngram} found within a corpus
}
\description{
This function identifies the top number(\code{num}) of user specified
n-grams(\code{ngram}) and provides a visual of each.
}
\details{
This function identifies all of the user specified n-grams (\emph{n} word co-occurrences
  in a sequence of text) in a corpus, sums the frequency of occurrence for
  each n-gram, and sorts the list in descending order. The function then
  provides an inverted bar chart identifying each n-gram and its frequency of
  occurrence down to a user specified lower-bound (\code{freq}).
}
\examples{
\donttest{
ngram.print(Articles, 2, 20)
}
}
