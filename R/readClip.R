#' Read clipboard regardless of OS
#' 
#' Different operating systems have different ways of handling the clipboard. 
#' Given the frequency with which text is copied to the clipboard to place in
#' an answer on StackOverflow, this utility is provided.
#' 
#' @return character string containing text on the clipboard.
#' 

readClip <- function() {
  OS <- Sys.info()["sysname"]
  
  cliptext <- switch(
    OS,
    Darwin = {
      con <- pipe("pbpaste")
      text <- readLines(con)
      close(con)
      text
      },
    Windows = readClipboard(),
    Linux = {
      if (Sys.which("xclip") == "") warning("Clipboard on Linux requires 'xclip'. Try using:\nsudo apt-get install xclip")
      con <- pipe("xclip -o -selection clipboard")
      text <- readLines(con = con)
      close(con)
      text
      },
    stop("Reading from clipboard not yet supported on your OS"))
  cliptext
}