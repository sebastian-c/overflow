\name{readSO}
\alias{readSO}
\title{Read in StackOverflow pasted table-formatted data}
\usage{
  readSO(sep = "", header = TRUE, stringsAsFactors = FALSE,
    out = "mydf")
}
\arguments{
  \item{sep}{character. Determines the field separator
  character passed to \code{read.table}. Alternatively,
  \code{sep} can be specified as "fwf" to attempt to read
  fixed-width-format files.}

  \item{header}{logical. Determines whether the first row
  consists of names of variables.}

  \item{stringsAsFactors}{logical. Whether strings are
  converted to factors or remain character variables.}

  \item{out}{character. Desired output object name.
  Defaults to \code{"mydf"}.}
}
\value{
  A data.frame as \code{read.table} produces.
}
\description{
  A wrapper for \link{read.table}. Reads a table from text
  or from the clipboard and creates a data.frame from it.
}
\details{
  For many questions at Stack Overflow, the question asker
  does not properly share their question (for example,
  using \code{\link{dput}} or by sharing some commands to
  make up the data). Most of the time, you can just copy
  and paste the text into R using \code{read.table(text =
  "clipboard", header = TRUE, stringsAsFactors = FALSE)}.
  This function is basically a convenience function for the
  above.

  The output of \code{\link{readSO}} is automatically
  assigned to an object in your workspace called
  "\code{mydf}" unless specified using the \code{out}
  argument.
}
\note{
  By default, stringsAsFactors is FALSE which is different
  to the R default.
}
\examples{
\dontrun{
## Copy the following text (select and ctrl-c)

# A B
# 1 2
# 3 4
# 5 6

## Now, just type:

readSO()

## Fixed-width-format example
## Copy the following text

Store     Min(Date)     Max (Date)     Status
NYC1       1/1/2013      2/1/2013      Open
NYC1       2/2/2013      2/3/2013      Closed for Inspection
Boston1    1/1/2013      2/5/2013      Open

## Now just type

readSO(sep = "fwf")

}
}
\author{
  Ananda Mahto
}
\seealso{
  \code{\link{dput}}, \code{\link{read.table}}
}

