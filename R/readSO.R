#'Read in StackOverflow pasted table-formatted data
#'
#'A wrapper for \link{read.table}. Reads a table from text or from the clipboard and creates a data.frame from it.
#'
#'For many questions at Stack Overflow, the question asker does not properly
#'share their question (for example, using \code{\link{dput}} or by sharing
#'some commands to make up the data). Most of the time, you can just copy and
#'paste the text into R using \code{read.table(text = "clipboard", header =
#'TRUE, stringsAsFactors = FALSE)}.  This function is basically a convenience
#'function for the above.
#'
#'The output of \code{\link{readSO}} is automatically assigned to an object in
#'your workspace called "\code{mydf}" unless specified using the \code{out}
#'argument.
#'
#' @param sep character. Determines the field separator character passed to \code{read.table}.
#' @param header logical. Determines whether the first row consists of names of variables.
#' @param stringsAsFactors logical. Whether strings are converted to factors or remain character variables.
#' @param out character. Desired output object name. Defaults to \code{"mydf"}.
#' @return A data.frame as \code{read.table} produces.
#' @note By default, stringsAsFactors is FALSE which is different to the R default.
#'
#' @export
#' @author Ananda Mahto
#' @seealso \code{\link{dput}}, \code{\link{read.table}}
#' @examples
#'
#'\dontrun{
#'## Copy the following text (select and ctrl-c)
#'
#'# A B
#'# 1 2
#'# 3 4
#'# 5 6
#'
#'## Now, just type:
#'
#'readSO()
#'}
#'
readSO <- function(sep = "", header = TRUE, stringsAsFactors = FALSE, out = "mydf") {
  OS <- ifelse(Sys.info()["sysname"] == "Darwin", "Mac", "others")
  temp <- switch(
    OS,
    Mac = {
      suppressWarnings(
        read.table(text = gsub("^#", "", pipe("pbpaste")), header = header, 
                   stringsAsFactors = stringsAsFactors, sep = sep))
    },
    others = {
      suppressWarnings(
        read.table(text = gsub("^#", "", readLines("clipboard")),
                   header = header, stringsAsFactors = stringsAsFactors, sep = sep))
    }) 
  assign(out, temp, envir = .GlobalEnv)
  message("data.frame ", dQuote(out), " created in your workspace")
  temp
}
