\name{SOcheck}
\alias{SOcheck}
\title{Check for errors and correct output when submitting SO questions}
\usage{
  SOcheck(script, dir = tempdir(),
    envir = as.environment("package:stats"))
}
\arguments{
  \item{script}{An expression in curly braces which you
  wish to test}

  \item{dir}{character. A temporary directory in which you
  want the script containing your code chunk to go.}

  \item{envir}{The environment in which the code is to be
  evaluated. In most cases, you will want this to be
  \code{package:stats} as this is the lowest in the
  hierarchy of packages which come installed with R.}
}
\description{
  Sometimes, you're not sure if what you've written will
  work on someone else's computer, given that you might
  have certain packages loaded or objects in your
  workspace. This function takes a block of code in curly
  braces and runs it in a new R session from the shell.
  Hence if there are errors, you'll see them produced
}
\examples{
\dontrun{
SOcheck({
  rnorm(10)
  library(stats)
  library(asdf)
  })
}
}
\author{
  Sebastian Campbell
}

