# Only purpose of this is so that we can 'mock' the `.Last.value` in testing

lastval <- function() .Last.value

#' Retrieve Last Call from History
#'
#' Returns the last call that was entered at the R prompt if it parsed
#' parsed successfully.  Because the history file may contain unparseable lines
#' and because it may not start from the beginning of an R session, it is not
#' possible to guarantee that we will be able to correctly retrieve the last
#' command.  This function will warn when it can retrieve a command but is not
#' certain the command is complete.
#'
#' @export
#' @author Brodie Gaslam
#' @param max.lookback integer(1L) how many lines of history to attempt to
#'   parse back from the end of the history file
#' @return language the last top level command, parsed

lastcall <- function(max.lookback=100L){
  if(
    !is.numeric(max.lookback) || length(max.lookback) != 1L ||
    is.na(max.lookback) || max.lookback < 0L
  )
    stop("`max.lookback` must be integer(1L), not NA, and positive")

  max.lookback <- as.integer(max.lookback)
  tmp <- tempfile()
  savehistory(tmp)
  on.exit(unlink(tmp))
  hist.rev <- rev(readLines(tmp))

  # Read from end until we reach end of file or `max.lookback` or something
  # that successfully parses to two expressions

  warn <- TRUE
  stop.line <- 0L
  parse.res.success <- NULL
  for(i in head(seq_along(hist.rev), max.lookback)) {
    parse.res <- try(parse(text=rev(head(hist.rev, i))), silent=TRUE)
    if(inherits(parse.res, "try-error")) next
    parse.res.success <- parse.res
    stop.line <- i
    if(length(parse.res) > 2L) {
      warn <- FALSE
      break
    }
  }
  if(length(parse.res.success) < 2L)
    stop(
      "Unable to retrieve final expression from last ", max.lookback,
      " history lines.  If you're sure the last command did not result ",
      "in a parse error, try increasing `max.lookback`."
    )
  if(warn) warning("We cannot guarantee that the last command was fully parsed")
  parse.res.success[[length(parse.res.success) - 1L]]
}
#' Capture Last Top Level Call And Output
#'
#' Captures the output from \code{.Last.value} along with the last expression
#' from the history file and formats them in a manner suitable for posting on
#' Stackoverflow.
#'
#' If you the expression you want captured spans multiple lines, enclose them
#' in a call to \code{\{}.  The curly braces will be dropped from the display
#' to make it appear as if you typed all the commands sequentially into the R
#' prompt, though any interim output will not be captured.
#'
#' Please note that the only output that is "captured" by this function is the
#' result of evaluating \code{.Last.value}.  If there were warning, errors, or
#' other screen output during the actual expression evaluation those will not
#' show up here.
#'
#' @author Andanda Mahto, Brodie Gaslam
#' @export
#' @seealso \code{\link{lastcall}} for limitations in capturing the last call
#' @param silent logical(1L) set to TRUE to suppress screen display
#' @param clip logical(1L) set to TRUE (default) to attempt to write to system
#'   clipboard
#' @param drop.curly.brace if the last call is a call to \code{\{}, drop it and
#'   show only the contents (see examples)
#' @param ... arguments to pass on to \code{\link{lastcall}}
#' @return character, invisibly, the call and value together formatted for
#'   posting on SO
#' @examples
#' \dontrun{
#' 1 + 1
#' solast()
#' {
#'   x <- runif(20)
#'   x + 3
#' }
#' solast()
#' }

solast <- function(silent=FALSE, clip=TRUE, drop.curly.brace=TRUE,...) {
  if(!isTRUE(silent) && !identical(silent, FALSE))
    stop("Argument `silent` must be TRUE or FALSE")
  if(!isTRUE(clip) && !identical(clip, FALSE))
    stop("Argument `clip` must be TRUE or FALSE")
  if(!isTRUE(drop.curly.brace) && !identical(drop.curly.brace, FALSE))
    stop("Argument `drop.curly.brace` must be TRUE or FALSE")

  output <- utils::capture.output(lastval())
  l.c <- lastcall(...)
  l.c.d <- if(identical(l.c[[1L]], as.name("{")) && drop.curly.brace) {
    unlist(lapply(tail(l.c, -1L), deparse))
  } else deparse(l.c)
  x <- noquote(paste0("    ", l.c.d))
  output_lines <- noquote(paste0("    ## ", output))
  lines <- c(x, output_lines)
  if(!silent) cat(lines, sep = "\n")
  invisible(lines)
}
