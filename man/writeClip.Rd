\name{writeClip}
\alias{writeClip}
\title{Write to clipboard on multiple OSes}
\usage{
  writeClip(object)
}
\arguments{
  \item{object}{character. Character to be copied to the
  clipboard}
}
\value{
  Returns nothing to R. Returns character string to the
  clipboard
}
\description{
  At the moment, this function only works on Windows and
  Mac. It copies a character string or vector of characters
  to the clipboard and interprets a vector of characters as
  one character with each element being newline separated.
}

