#' Add random NAs to each column of a data frame
#' 
#' @param object data.frame to which NAs should be added
#' @param columns numeric or character. Vector containing names or column 
#'   numbers in which NAs are to be placed.
#' @param numeric. Number between 0 and 1 indicating the proportion of NAs to be
#'   placed in each selected column.
#'   
#' @return data.frame like the original but with NAs inserted in the selected
#'   columns.
#'   
#' @author Sebastian Campbell
#' 
#' @examples
#' soaddnas(sorandf(), columns=c("race", "gender"))
#' soaddnas(sorandf(), columns=c(1,2))
#' 
#' @export soaddnas

soaddnas <- function(object, columns="all", narate=0.1){
  if(all(columns == "all")){columns <- TRUE}
  
  nrowc <- nrow(object)
  na_no <- round(narate * nrowc)
  
  tempobject <- object[,columns, drop=FALSE]
  
  tempobject <- sapply(tempobject, addnacol, na_no, nrowc)
  object[,columns] <- tempobject
  object

}

addnacol <- function(col, no, totno){
  col[sample.int(totno, no)] <- NA
  col
}