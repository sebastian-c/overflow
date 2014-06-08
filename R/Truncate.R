#' Truncate the Output of Dataframes, Matrices and Lists
#' 
#' A dispaly printing function that trunates \code{data.frame}/\code{matrix} by 
#' adding ellipsis \ldots to take the place of non-displayed columns and rows.
#' 
#' @param x An R object (usually a \code{data.frame}, \code{matrix}, or a 
#' \code{list} that contains >= 1 \code{data.frame}/\code{matrix}.
#' @param ncol The number of columns (including 3 columns displayed as ellipsis) 
#' to display.
#' @param nrow The number of rows (including 3 rows displayed as ellipsis) to 
#' display.
#' @param \ldots Other arguments passed to \code{Truncate}.
#' @note This function is intended for truncated display.  Please do not use to 
#' gernarate your \href{http://sscce.org/}{SSCCE}
#' (Short, Self Contained, Correct (Compilable), Example).
#' @return Prints a truncated display of the input.
#' @keywords truncate
#' @export
#' @rdname Truncate
#' @examples
#' Truncate(mtcars)
#' Truncate(mtcars, nrow = 6)
#' Truncate(mtcars, ncol = 6)
#' Truncate(CO2)
#' Truncate(lm(mpg~hp+am, data=mtcars))
#' Truncate(1:10)
#' Truncate(mtcars[1:5, 1:5])
Truncate <- function(x, ncol = 10, nrow=15, ...){

    if (ncol < 4 | nrow < 4) stop("`ncol` & `nrow` arguments must be > 3")

    x
    ncol
    nrow

    UseMethod("Truncate")

}

#' \code{Truncate.matrix} - matrix method for \code{Truncate}
#' @rdname Truncate
#' @export
#' @method Truncate matrix 
Truncate.matrix <- function(x, ncol = 10, nrow=15, ...){

    Truncate_helper(x=x, ncol = ncol, nrow=nrow)
     
}

#' \code{Truncate.data.frame} - data.frame method for \code{Truncate}
#' @rdname Truncate
#' @export
#' @method Truncate data.frame 
Truncate.data.frame <- function(x, ncol = 10, nrow=15, ...){

    Truncate_helper(x=x, ncol = ncol, nrow=nrow)

}

#' \code{Truncate.list} - list method for \code{Truncate}
#' @rdname Truncate
#' @export
#' @method Truncate list 
Truncate.list <- function(x, ncol = 10, nrow=15, ...){

    Truncate_list_helper(x=x, ncol = ncol, nrow=nrow)
     
}

#' \code{Truncate.default} - Default method for \code{Truncate}
#' @rdname Truncate
#' @export
#' @method Truncate default 
Truncate.default <- function(x, ncol = 10, nrow=15, ...){

    if (is.list(x)) {
        Truncate_list_helper(x=x, ncol = ncol, nrow=nrow)
    } else {
        if (!any(sapply(Truncate_checks, function(f) f(x)))) {
            return(x)
        }
        Truncate_helper(x=x, ncol = ncol, nrow=nrow)
    } 
}


Truncate_checks <- gsub("Truncate", "is", methods(Truncate))
Truncate_checks <- sapply(Truncate_checks[Truncate_checks != "is.default"], match.fun)


Truncate_col <- function(x, ncol = 10) {

    if (!(ncol(x) <= ncol)) {

        firstc <- 1:(ncol - 4)
        lastc <- ncol(x)  
    
        core <- x[, firstc, drop=FALSE]
        core <- cbind.data.frame(core, matrix(rep(".", nrow(core) * 3), ncol=3))
        lenc <- ncol(core)
        colnames(core)[(lenc-2):lenc] <- "."
        core <-  cbind.data.frame(core, x[, lastc, drop=FALSE])

    } else {
        core <- x
    }

    m <- capture.output(core) 
    space <- max(nchar(m)) - 1   
    n <- data.frame(m[-1], stringsAsFactors = FALSE)
    colnames(n) <- m[1]
    n
}


Truncate_row <- function(x, nrow = 15) {

    if (nrow(x) <= nrow) return(x)

    if (ncol(x) > 1 || !is.character(x[, 1]) || sum(diff(nchar(x[, 1]))) != 0){
    
        m <- capture.output(x) 
        space <- max(nchar(m)) - 1   
        x <- data.frame(m[-1], stringsAsFactors = FALSE)
        colnames(x) <- m[1]
    }

    firstr <- 1:(nrow - 3)
    lastr <- nrow(x)      

    m <- x[c(firstr, lastr), ]
 
    space <- max(nchar(m)) - 1
    m <- c(head(m, -1), paste0(rep(".", 3), paste(rep(" ", space), collapse ="")), tail(m, 1))
    
    o <- data.frame(m[-1], stringsAsFactors = FALSE)
    nms <- capture.output(x)[1]
    tchar <- nchar(o[1,1])
    nmschar <- nchar(nms)
    colnames(o) <- substring(nms, nmschar-(tchar - 1))
    print(o, quote=FALSE, row.names=FALSE)
}

Truncate_helper <- function(x, ncol = 10, nrow = 15){
    Truncate_row(Truncate_col(x, ncol = ncol), nrow = nrow)
}


Truncate_list_helper <- function(x, ncol = 10, nrow=15){

    lapply(x, function(y) {

        if (!any(sapply(Truncate_checks, function(f) f(y)))) {
            return(y)
        }

        Truncate(y, ncol = ncol, nrow=nrow)
    })
}





