\name{tmp.install.packages}
\alias{tmp.install.packages}
\title{Temporarily install a package in the current R session}
\usage{
  tmp.install.packages(package, dependencies = TRUE, ...)
}
\arguments{
  \item{package}{a package name, or a character vector of
  package names}

  \item{dependencies}{argument passed to
  \code{install.packages}. Default to TRUE.}

  \item{...}{other arguments passed to
  \code{install.packages}}
}
\description{
  This function can be useful when a package is necessary
  to try to answer a question on StackOverlfow and you know
  that you won't need it anymore afterward. It will install
  one or several packages only for the current R session.
}
\details{
  The files are downloaded and installed in a temporary
  directory, and this directory is temporarily added to the
  library trees within which packages are looked for
  (\code{.libPaths}). If you start another R session, the
  package won't be accessible as it won't be in the library
  trees anymore, and as the files are installed in a
  temporary directory they should be deleted upon next
  reboot (this depends on your operating system).
}
\examples{
\dontrun{
## Temporarily install the ggplot2 package in the current R session
tmp.install.packages("ggplot2")
}
}
\author{
  Julien Barnier
}
\seealso{
  \code{\link{install.packages}}, \code{\link{.libPaths}}
}

