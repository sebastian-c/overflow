#' Check for errors and correct output when submitting SO questions
#'
#' Sometimes, you're not sure if what you've written will work on someone else's computer, given that 
#' you might have certain packages loaded or objects in your workspace. This function takes a block of
#' code in curly braces and runs it in a new R session from the shell. Hence if there are errors, you'll
#' see them produced
#' 
#' @author Sebastian Campbell
#' 
#' @param script An expression in curly braces which you wish to test
#' @param dir character. A temporary directory in which you want the script containing 
#' your code chunk to go.
#' 
#' @examples
#' 
#' \dontrun{
#' SOcheck({
#'   rnorm(10)
#'   library(stats)
#'   library(asdf)
#'   })
#' }
#' 
#' @export

SOcheck <- function(script, dir=tempdir()){
  scripttext <- deparse(substitute(script))
  if(all(grepl("[{}]", scripttext[c(1, length(scripttext))]))){
    scripttext <- scripttext[-c(1, length(scripttext))]
  }
    sourcefile <- paste0(scripttext, collapse="\n")
  write(scripttext, file.path(dir, "SOcheckfile.R"))
  cat(suppressWarnings(
    paste0(system(paste0("Rscript --vanilla ", file.path(dir, "SOcheckfile.R")), intern=TRUE), collapse="\n")
  ))
}