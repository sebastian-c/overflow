#' Create random data.frame
#' 
#' @aliases sorandf_add sorandf_reset
#' 
#' @param rows integer, number of rows in data.frame
#' @param cols types of columns
#' @param names names of columns
#' @param newf function to add to sorandf functions. Must have just one
#'   parameter, n.
#' @param name name to call new function
#'   
#' @details Within this function, there are a number of defaults which can be
#'   called by default:
#'   
#' \code{id = function(n) paste0("ID.", 1:n)}
#' 
#' \code{group = function(n) sample(c("control", "treat"), n, replace = TRUE)}
#' 
#' \code{hs.grad = function(n) sample(c("yes", "no"), n, replace = TRUE)}
#' 
#' \code{race = function(n) sample(c("black", "white", "asian"), n, 
#'                          replace = TRUE, prob=c(.25, .5, .25))}
#'                          
#' \code{gender = function(n) sample(c("male", "female"), n, replace = TRUE)}
#' 
#' \code{age = function(n) sample(18:40, n, replace = TRUE)}
#' 
#' \code{m.status = function(n) sample(c("never", "married", "divorced", "widowed"), 
#'                               n, replace = TRUE, prob=c(.25, .4, .3, .05))}
#'                               
#' \code{political = function(n) sample(c("democrat", "republican", 
#'                                  "independent", "other"), n, replace= TRUE, 
#'                                prob=c(.35, .35, .20, .1))}
#'                                
#' \code{n.kids = function(n) rpois(n, 1.5)}
#' 
#' \code{income = function(n) sample(c(seq(0, 30000, by=1000),
#'                               seq(0, 150000, by=1000)), n, replace=TRUE)}
#'                               
#' \code{score = function(n) rnorm(n)}
#' 
#' @examples
#' \dontrun{
#' sorandf(15, c("id", "age", "score"), names= c("card", "years", "points"))
#' 
#' sorandf_add(function(n){sample(1:10, n)}, "newf")
#' sorandf(10, c("gender", "race", "newf"))
#' sorandf_reset()
#' }
#'   
#' @export sorandf sorandf_reset sorandf_add

sorandf <- function(rows=10L, cols=c("race", "gender", "age"), names=make.names(cols)){
  
  setNames(as.data.frame(lapply(cols, function(x) get(x, envir=.so.env)(rows))), names)
  
}

#' @rdname sorandf

sorandf_add <- function(newf, name){
  
  if(name %in% ls(env=.so.env)){
    warning(paste0("existing function with name: ", name, " overwritten"))
  }
  assign(name, newf, envir=.so.env)
}

#' @rdname sorandf

sorandf_reset <- function(){
  rm(list=ls(envir=.so.env), envir=.so.env)
  invisible(mapply(assign, names(base.list), base.list, MoreArgs=list(envir=.so.env)))
}

base.list <- list(id = function(n) paste0("ID.", 1:n), 
                group = function(n) sample(c("control", "treat"), n, replace = TRUE),
                hs.grad = function(n) sample(c("yes", "no"), n, replace = TRUE), 
                race = function(n) sample(c("black", "white", "asian"), n, 
                              replace = TRUE, prob=c(.25, .5, .25)), 
                gender = function(n) sample(c("male", "female"), n, replace = TRUE), 
                age = function(n) sample(18:40, n, replace = TRUE),
                m.status = function(n) sample(c("never", "married", "divorced", "widowed"), 
                                  n, replace = TRUE, prob=c(.25, .4, .3, .05)), 
                political = function(n) sample(c("democrat", "republican", 
                                     "independent", "other"), n, replace= TRUE, 
                                   prob=c(.35, .35, .20, .1)),
                n.kids = function(n) rpois(n, 1.5), 
                income = function(n) sample(c(seq(0, 30000, by=1000), 
                                  seq(0, 150000, by=1000)), n, replace=TRUE),
                score = function(n) rnorm(n)
                )

.so.env <- as.environment(base.list)


