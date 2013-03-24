\name{readSO}
\alias{readSO}
\title{Read in StackOverflow table-formatted data}
\usage{
  readSO(sep = "", header = TRUE, stringsAsFactors = FALSE)
}
\arguments{
  \item{sep}{character. Determines the field separator
  character passed to \code{read.table}.}

  \item{header}{logical. Determines whether the first row
  consists of names of variables.}

  \item{stringsAsFactors}{logical. Whether strings are
  converted to factors or remain character variables.}
}
\value{
  A data.frame as read.table produces.
}
\description{
  A wrapper for \link{read.table}. Reads a table from text
  or from the clipboard and creates a data.frame from it.
}
\note{
  By default, stringsAsFactors is FALSE which is different
  to the R default.
}
\author{
  Ananda Mahto
}

