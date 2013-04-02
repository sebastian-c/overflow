#' Write to clipboard on multiple OSes
#' 
#' At the moment, this function only works on Windows and Mac. It copies a 
#' character string or vector of characters to the clipboard and interprets
#' a vector of characters as one character with each element being newline
#' separated.
#' 
#' @param object character. Character to be copied to the clipboard
#' 
#' @return Returns nothing to R. Returns character string to the clipboard
#' 

writeClip <- function(object){
  OS <- Sys.info()["sysname"]
  
  if(!(OS %in% c("Darwin", "Windows"))) stop("Copying to clipboard not yet supported on your OS")
    
  switch(OS,
         "Darwin"={con <- pipe("pbcopy", "w")
                   writelines(object, con=con)
                   close(con)},
         "Windows"=writeClipboard(object, format = 1))
}