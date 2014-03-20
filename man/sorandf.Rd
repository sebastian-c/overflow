\name{sorandf}
\alias{sorandf}
\alias{sorandf_add}
\alias{sorandf_reset}
\title{Create random data.frame}
\usage{
sorandf(rows = 10L, cols = c("race", "gender", "age"),
  names = make.names(cols))

sorandf_reset()

sorandf_add(newf, name)
}
\arguments{
  \item{rows}{integer, number of rows in data.frame}

  \item{cols}{types of columns}

  \item{names}{names of columns}

  \item{newf}{function to add to sorandf functions. Must
  have just one parameter, n.}

  \item{name}{name to call new function}
}
\description{
Create random data.frame
}
\details{
Within this function, there are a number of defaults which
can be called by default:

\code{id = function(n) paste0("ID.", 1:n)}

\code{group = function(n) sample(c("control", "treat"), n,
replace = TRUE)}

\code{hs.grad = function(n) sample(c("yes", "no"), n,
replace = TRUE)}

\code{race = function(n) sample(c("black", "white",
"asian"), n, replace = TRUE, prob=c(.25, .5, .25))}

\code{gender = function(n) sample(c("male", "female"), n,
replace = TRUE)}

\code{age = function(n) sample(18:40, n, replace = TRUE)}

\code{m.status = function(n) sample(c("never", "married",
"divorced", "widowed"), n, replace = TRUE, prob=c(.25, .4,
.3, .05))}

\code{political = function(n) sample(c("democrat",
"republican", "independent", "other"), n, replace= TRUE,
prob=c(.35, .35, .20, .1))}

\code{n.kids = function(n) rpois(n, 1.5)}

\code{income = function(n) sample(c(seq(0, 30000, by=1000),
seq(0, 150000, by=1000)), n, replace=TRUE)}

\code{score = function(n) rnorm(n)}
}
\examples{
\dontrun{
sorandf(15, c("id", "age", "score"), names= c("card", "years", "points"))

sorandf_add(function(n){sample(1:10, n)}, "newf")
sorandf(10, c("gender", "race", "newf"))
sorandf_reset()
}
}

