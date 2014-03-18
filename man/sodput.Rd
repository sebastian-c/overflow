\name{sodput}
\alias{sodput}
\title{Create complete code to create an object and copy to clipboard}
\usage{
sodput(object, rows = TRUE, indents = 4, mdformat = TRUE)
}
\arguments{
  \item{object}{R object to convert to code}

  \item{rows}{numeric. Vector of row numbers. These rows
  will be produced in the output. By default, all rows are
  included.}

  \item{indents}{integer. Spaces to be added before each
  line}

  \item{mdformat}{logical. Whether or not to add 4 spaces
  before every line in order to format as a code block.}
}
\description{
In several cases, you may want to give a sample dataset.
\code{dput} is a great tool for doing so. This tool takes
the \code{dput} output and places it on the clipboard, as
well as adding an assignment operator.
}
\examples{
\dontrun{
sodput(mtcars)
sodput(mtcars, rows=1:6)
}
}
\author{
Tyler Rinker
}

