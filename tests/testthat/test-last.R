library("overflow")
context("solast")
test_that("lastcall", {
  hist.dat <- list(
    "1 + 1\nlastcall()\n",
    "1 + 1\n2 + 2\nlastcall()\n",
    "1\n{\nx <- 3\nx + 1:3}\nlastcall()\n",
    "1 + 1\n}\nlastcall()\n",
    "1\n}\n1 + 1\nlastcall()\n",
    paste0(c("{", 1:90, "x <- 5\nx\n}\nx / 2\nlastcall()\n"), collapse="\n")
  )
  sl <- function(x) tail(x, 2L)[[1L]] # second to last value
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[1L]]),
    expect_warning(res <- lastcall(), "We cannot guarantee"),
    expect_equal(res, sl(parse(text=hist.dat[[1L]])))
  )
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[2L]]),
    expect_equal(lastcall(), sl(parse(text=hist.dat[[2L]])))
  )
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[3L]]),
    expect_equal(lastcall(), sl(parse(text=hist.dat[[3L]])))
  )
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[4L]]),
    expect_error(lastcall(), "Unable to retrieve")
  )
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[5L]]),
    expect_warning(lastcall(), "We cannot guarantee")
  )
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[6L]]),
    expect_equal(lastcall(), sl(parse(text=hist.dat[[6L]])))
  )
  # Here we hit `max.lookback` before we can fully parse prior expression
  with_mock(
    savehistory=function(file) writeLines(con=file, hist.dat[[6L]]),
    expect_warning(res <- lastcall(max.lookback=6L), "We cannot guarantee"),
    expect_equal(res, sl(parse(text=hist.dat[[6L]])))
  )
  expect_error(lastcall("hello"), "integer")
})
test_that("solast", {
  expect_error(solast(silent="hello"), "TRUE or FALSE")
  expect_error(solast(clip="hello"), "TRUE or FALSE")
  expect_error(solast(drop.curly.brace="hello"), "TRUE or FALSE")
  hist <- "1\n{\nx <- 1\nx\n}\nsolast()\n"

  res.sub <- c("x <- 1", "x")
  res.res <- "## [1] 1"
  res.1 <- noquote(paste0("    ", c(res.sub, res.res)))
  res.2 <- noquote(paste0("    ", c("{", paste0("    ", res.sub), "}", res.res)))

  with_mock(
    savehistory=function(file) writeLines(con=file, hist),
    .env=getNamespace("overflow"),
    lastval=function() 1,
    print(solast()),
    print(res.1),
    expect_equal(solast(), res.1),
    expect_equal(noquote(capture.output(solast())), res.1),
    expect_equal(capture.output(solast(silent=TRUE)), character(0L)),
    expect_equal(solast(drop.curly.brace=FALSE), res.2),
    expect_error(solast(max.lookback=1L), "Unable to retrieve")
  )
})
