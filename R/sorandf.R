#' Create random data.frame
#' 
#' @param rows integer, number of rows in data.frame
#' @param cols types of columns
#' @param names names of columns
#' 
#' @export sorandf


sorandf <- function(rows=10L, cols=c("race", "gender", "age"), names=make.names(cols)){
  
  setNames(as.data.frame(lapply(cols, function(x) get(x, envir=.so.env)(rows))), names)
  
}

.so.env <- as.environment(list(id = function(n) paste0("ID.", 1:n), 
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
                ))

