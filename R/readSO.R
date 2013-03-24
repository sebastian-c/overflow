#' Read in StackOverflow table-formatted data
#' 
#' A wrapper for \link{read.table}. Reads a table from text or from the clipboard and creates a data.frame from it.
#' 
#' @author Ananda Mahto
#'
#' @param sep character. Determines the field separator character passed to \code{read.table}.
#' @param header logical. Determines whether the first row consists of names of variables.
#' @param stringsAsFactors logical. Whether strings are converted to factors or remain character variables.
#' @return A data.frame as read.table produces.
#' @note By default, stringsAsFactors is FALSE which is different to the R default.
#'
#' @export

readSO <- function(sep = "", header = TRUE, stringsAsFactors = FALSE) {
  suppressWarnings(
    read.table(text = gsub("^#", "", readLines("clipboard")),
               header = header, stringsAsFactors = stringsAsFactors,
               sep = sep))
}
