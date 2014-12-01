#' Turn an R expression into an SO answer
#' 
#' Parrot the input expression and append the output with knitr-style comments,
#' all as markdown.
#' @param expr An R expression.
#' @return Markdown output is printed to the console, written to the clipboard 
#' and silently returned as a \code{noquote} character vector.
#' @examples
#' soanswer(sin(2 * pi))
#' soanswer(sleep)
#' soanswer(message("A message!"))
#' soanswer(warning("A warning!"))
#' soanswer(stop("An error!"))
#' @importFrom utils capture.output
#' @export
soanswer <- function(expr)
{
  input_lines <- noquote(paste0("    ", deparse(substitute(expr))))
  output <- tryCatch(
    utils::capture.output(print(expr)),
    message = function(m) substring(m$message, 1, nchar(m$message) - 1),
    warning = function(w) w$message,
    error = function(e) e$message        
  )
  output_lines <- noquote(paste0("    ## ", output))
  lines <- c(input_lines, output_lines)
  cat(lines, sep = "\n")
  writeClip(lines) 
  invisible(lines)
}
