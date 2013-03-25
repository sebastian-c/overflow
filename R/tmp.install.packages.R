##' Temporarily install a package in the current R session
##'
##' This function can be useful when a package is necessary to try to answer a question
##' on StackOverlfow and you know that you won't need it anymore afterward. It will install
##' one or several packages only for the current R session.
##'
##' The files are downloaded and installed in a temporary directory, and this
##' directory is temporarily added to the library trees within which packages are
##' looked for (\code{.libPaths}). If you start another R session, the package
##' won't be accessible as it won't be in the library trees anymore, and as the
##' files are installed in a temporary directory they should be deleted upon next
##' reboot (this depends on your operating system).
##'
##' @note
##' You can find alternative functions in the original question and answers on
##' StackOverflow :
##'
##' \url{http://stackoverflow.com/questions/14896941/install-an-r-package-temporarily-only-for-the-current-session}
##' 
##' @param package a package name, or a character vector of package names
##' @param dependencies argument passed to \code{install.packages}. Default to TRUE.
##' @param ... other arguments passed to \code{install.packages}
##' @export
##' @author Julien Barnier <julien@@nozav.org>
##' @seealso \code{\link{install.packages}}, \code{\link{.libPaths}}
##' @examples
##'
##' \dontrun{
##' ## Temporarily install the ggplot2 package in the current R session
##' tmp.install.packages("ggplot2")
##' }

tmp.install.packages <- function(package, dependencies=TRUE, ...) {
  path <- tempdir()
  ## Add 'path' to .libPaths, and be sure that it is not
  ## at the first position, otherwise any package during
  ## this session would be installed into 'path'
  if (!(path %in% .libPaths())) {
    firstpath <- .libPaths()[1]
    .libPaths(c(firstpath, path))
  }
  install.packages(package, dependencies=dependencies, lib=path, ...)
}
