\name{soaddnas}
\alias{soaddnas}
\title{Add random NAs to each column of a data frame}
\usage{
soaddnas(object, columns = "all", narate = 0.1)
}
\arguments{
  \item{object}{data.frame to which NAs should be added}

  \item{columns}{numeric or character. Vector containing
  names or column numbers in which NAs are to be placed.}

  \item{numeric.}{Number between 0 and 1 indicating the
  proportion of NAs to be placed in each selected column.}
}
\description{
Add random NAs to each column of a data frame
}
\author{
Sebastian Campbell
}

