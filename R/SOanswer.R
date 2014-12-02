#' Turn an R expression into an SO answer
#' 
#' Parrot the input expression and append the output with knitr-style comments,
#' all as markdown.  \code{soanswer} changes the output for a single expression.
#' \code{soon} changes the output for all expressions until you call 
#' \code{sooff}.
#' @param expr An R expression.
#' @param in_task_callback A logical value.  Not intended for direct use.
#' @return Markdown output is printed to the console, written to the clipboard 
#' and silently returned as a \code{noquote} character vector.
#' @note \code{soon} is not currently working correctly for errors.  Use
#' \code{soanswer} for those instead.
#' @seealso \code{\link[base]{addTaskCallback}}
#' @examples
#' # Output for various types, explicitly calling soanswer
#' soanswer(sin(2 * pi))
#' soanswer(sleep)
#' soanswer(message("A message!"))
#' soanswer(warning("A warning!"))
#' soanswer(stop("An error!"))
#' # The same again, with output globally altered
#' soon()
#' sin(2 * pi)
#' sleep
#' message("A message!")
#' warning("A warning!")
#' stop("An error!")
#' sooff()
#' @importFrom utils capture.output
#' @export
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

TEMP_SINK <- file.path(tempdir(), "Rsink.Rout")

#' @rdname soanswer
#' @export
soon <- function()
{
  addTaskCallback(
    function(expr, value, ok, visible) 
    {
      # First time usage
      if(identical(expr, quote(soon())))
      {
        fcon <<- file(TEMP_SINK, "wt")
        sink(fcon, type = "output")
        sink(fcon, type = "message")
        return(invisible(TRUE))
      }
      # Usage on further calls
      sink(type = "message") # must close the sinks in reverse order
      sink(type = "output")
      soanswer(expr, in_task_callback = TRUE)
      sink(fcon, type = "output")
      sink(fcon, type = "message")
     invisible(TRUE)
    }, 
    name = "somode"
  )
}

sooff <- function()
{
  removeTaskCallback("somode")
  sink(type = "message")
  sink(type = "output")
  close(fcon)
  unlink(TEMP_SINK)
  invisible()
}
