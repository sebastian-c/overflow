#' Write to clipboard on multiple OSes
#' 
#' This function works on Windows, Mac and Linux. It copies a 
#' character string or vector of characters to the clipboard and interprets
#' a vector of characters as one character with each element being newline
#' separated. If using Linux, xclip is used as the clipboard. So for the
#' function to work, xclip must be installed.
#' 
#' @param object character. Character to be copied to the clipboard
#' 
#' @return Returns nothing to R. Returns character string to the clipboard
#' 
#' @details If using Linux, xclip will be used as the clipboard. To paste from 
#' xclip, either use middle click or the command \code{xclip -o} in the shell.
#' 

writeClip <- function(object){
  OS <- Sys.info()["sysname"]
  
  if(!(OS %in% c("Darwin", "Windows", "Linux"))) stop("Copying to clipboard not yet supported on your OS")
    
  switch(OS,
         "Darwin"={con <- pipe("pbcopy", "w")
                   writeLines(object, con=con)
                   close(con)},
         "Windows"=writeClipboard(object, format = 1),
         "Linux"={if(Sys.which("xclip") == "") stop("Clipboard on Linux requires 'xclip'. Try using:\nsudo apt-get install xclip")
                  con <- pipe("xclip -i", "w")
                  writeLines(object, con=con)
                  close(con)})
}
