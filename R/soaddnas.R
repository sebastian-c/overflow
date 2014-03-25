#' Add random NAs to each column of a data frame
#'
#' @param object data.frame to which NAs should be added
#' @param columns nu
#'
#' @author Sebastian Campbell
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