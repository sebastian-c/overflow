#' Create complete code to create an object and copy to clipboard
#' 
#' In several cases, you may want to give a sample dataset. \code{dput} is a great tool for doing so. This tool takes 
#' the \code{dput} output and places it on the clipboard, as well as adding an assignment operator.
#'
#' @param object R object to convert to code
#' @param rows numeric. Vector of row numbers. These rows will be produced in the output. 
#' By default, all rows are included.
#' @param indents integer. Spaces to be added before each line
#' @param mdformat logical. Whether or not to add 4 spaces before every line in order to format as a code block.
#' 
#' @author Tyler Rinker
#' 
#' @examples
#' \dontrun{
#' sodput(mtcars)
#' sodput(mtcars, rows=1:6)
#' }
#' @export

sodput <- function(object, rows=TRUE, indents = 4, mdformat=TRUE) {
  name <- as.character(substitute(object))
  name <- name[length(name)]
  
  if(inherits(object, c("matrix", "data.frame"))) object <- object[rows,]
  obj <- capture.output(dput(object))
  obj[1] <- paste(name, "<-", obj[1])
  obj[-1] <- paste0(paste(rep(" ", indents), collapse=""), obj[-1])
  
  if(mdformat) obj <- paste0("    ", obj)
  
  zz <- as.matrix(as.data.frame(obj))
  dimnames(zz) <- list(c(rep("", nrow(zz))), c(""))

  writeClip(obj)                                     
  noquote(zz)   
}
