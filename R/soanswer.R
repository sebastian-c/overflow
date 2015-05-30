#' Turn an R expression into an SO answer
#' 
#' Parrot the input expression and append the output with knitr-style comments,
#' all as markdown.  \code{soanswer} changes the output for a single expression.
#' @param expr An R expression.
#' @param in_task_callback A logical value.  Not intended for direct use.
#' @return Markdown output is printed to the console, written to the clipboard 
#' and silently returned as a \code{noquote} character vector.
#' @author Richard Cotton
#' @seealso \code{\link[base]{addTaskCallback}}
#' @examples
#' # Output for various types, explicitly calling soanswer
#' soanswer(sin(2 * pi))
#' soanswer(sleep)
#' soanswer(message("A message!"))
#' soanswer(warning("A warning!"))
#' soanswer(stop("An error!"))
#' @importFrom utils capture.output
#' @export soanswer
soanswer <- function(expr, in_task_callback = FALSE)
{
  input_lines <- noquote(
    paste0(
      "    ", 
      if(in_task_callback)
      {
        deparse(expr)
      } else
      {
        deparse(substitute(expr))
      }
    )
  )
  output <- tryCatch(
    utils::capture.output(print(if(in_task_callback) eval(expr) else expr)),
    message = function(m) substring(m$message, 1, nchar(m$message) - 1),
    warning = function(w) c("Warning message:", w$message),
    error   = function(e) paste("Error:", e$message)        
  )
  output_lines <- noquote(paste0("    ## ", output))
  lines <- c(input_lines, output_lines)
  cat(lines, sep = "\n")
  writeClip(lines) 
  invisible(lines)
}
