# overflow

An R package to assist people answering R questions on Stack Overflow.

Authors: Sebastian Campbell, Ananda Mahto, Julien Barnier, Tyler Rinker, Richard Cotton

Maintainer: Sebastian Campbell

## Installation and Usage

The easiest way to install this package is to use `install_github`:

```R
source("http://jtilly.io/install_github/install_github.R")
install_github("mrdwab/overflow-mrdwab")
```

Once installed, simply use the following to access the functions:

```
library(overflow)
```

## Functions

### Main Functions

Function|Description
-------|-----------
`soread`|Reads data directly from the clipboard and creates an object named "mydf" in your workspace.
`soanswer`|Writes a call and its output to the clipboard, already formatted for pasting into an answer at Stack Overflow.
`sodput`|A modified version of `dput` that copies your data to your clipboard, to be pasted into a question or an answer at Stack Overflow.
`sopkgs`|Temporarily installs a package in the current R session.

### Additional Functions

Function|Description
-------|---------
`sotrunc`|Truncate the output of `data.frame`s, matrices, and lists.
`sorandf`|Function to create a random `data.frame`.

