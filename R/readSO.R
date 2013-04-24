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
#' @param sep character. Determines the field separator character passed to \code{read.table}. Alternatively, \code{sep} can be specified as "fwf" to attempt to read fixed-width-format files.
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
#'
#'## Fixed-width-format example
#'## Copy the following text
#'
#'Store     Min(Date)     Max (Date)     Status
#'NYC1       1/1/2013      2/1/2013      Open
#'NYC1       2/2/2013      2/3/2013      Closed for Inspection
#'Boston1    1/1/2013      2/5/2013      Open
#'
#'## Now just type
#'
#'readSO(sep = "fwf")
#'
#'}
#'
readSO <- function(sep = "", header = TRUE, stringsAsFactors = FALSE, out = "mydf") {
  temp <- gsub("^[# ]+", "", suppressWarnings(readClip()))
  
  if (sep == "fwf") {
    temp <- readSOfwf(inData = temp, header = header, 
                      stringsAsFactors = stringsAsFactors)
  } else {
    temp <- read.table(text = temp, header = header, 
                       stringsAsFactors = stringsAsFactors, sep = sep)
  }
  
  assign(out, temp, envir = .GlobalEnv)
  message("data.frame ", dQuote(out), " created in your workspace")
  temp
}
NULL

#'Read in pasted table-formatted data which have spaces in columns
#'
#'\code{readSO} (and similarly, \code{read.table}) cannot be used when some of the columns in a dataset have spaces. This function hooks into \code{readSO} to add such functionality by first trying to convert the dataset into a CSV format.
#'
#'@note This function is not meant to be called on its own, but rather through \code{\link{readSO}} which handles some initial pre-processing of the copied text strings. See the \code{readSO} help page for examples.
#'
#'@return A \code{data.frame}.
#'
#'@author Ananda Mahto
#'
readSOfwf <- function(inData, stringsAsFactors = FALSE, header = TRUE, out = "mydf") {
  myStrings <- gsub("\\s\\s+", ",", inData)
  
  temp <- read.csv(text = myStrings, header = header,
                   stringsAsFactors = stringsAsFactors)
  
  if (isTRUE(dropFirst)) temp <- temp[-1]
  else temp <- temp
}
NULL
