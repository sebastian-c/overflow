\name{readSOfwf}
\alias{readSOfwf}
\title{Read in pasted table-formatted data which have spaces in columns}
\usage{
  readSOfwf(inData, stringsAsFactors = FALSE,
    header = TRUE, out = "mydf")
}
\value{
  A \code{data.frame}.
}
\description{
  \code{readSO} (and similarly, \code{read.table}) cannot
  be used when some of the columns in a dataset have
  spaces. This function hooks into \code{readSO} to add
  such functionality by first trying to convert the dataset
  into a CSV format.
}
\note{
  This function is not meant to be called on its own, but
  rather through \code{\link{readSO}} which handles some
  initial pre-processing of the copied text strings. See
  the \code{readSO} help page for examples.
}
\author{
  Ananda Mahto
}

