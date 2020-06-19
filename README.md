# overflow

An R package to assist people answering R questions on Stack Overflow.

Authors: Sebastian Campbell, Ananda Mahto, Julien Barnier, Tyler Rinker, Richard Cotton, Brodie Gaslam

Maintainer: Ananda Mahto

## Installation and Usage

The easiest way to install this package is to use `install_github`:

```R
source("http://news.mrdwab.com/install_github.R")
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
`solast`|Captures the output from `.Last.value` along with the last expression from the history file and formats them in a manner suitable for posting on Stack Overflow.
`sodput`|A modified version of `dput` that copies your data to your clipboard, to be pasted into a question or an answer at Stack Overflow.
`sopkgs`|Temporarily installs a package in the current R session.

### Additional Functions

Function|Description
-------|---------
`sotrunc`|Truncate the output of `data.frame`s, matrices, and lists.
`sorandf`|Function to create a random `data.frame`. It's probably better to just head over to [Tyler's "Wakefield" package](https://github.com/trinker/wakefield) rather than use this. 

## Examples

Examples can be found in the "Examples" section of the relevant helpfile, but essentially, you get the following:

### `soread`

```
## Copy the following text (select and ctrl-c)

# A B
# 1 2
# 3 4
# 5 6

## Now, just type the following to create a data.frame in your workspace

soread()

## Copying tibbles (select from the line after `# A tibble: ...` and ctrl-c)

# A tibble: 3 x 2
      A     B
  <dbl> <dbl>
1     1     5
2     2     3
3     3    11

soread(skipAfterHeader = TRUE, out = "mydf2")

```

### `soanswer`

```
> soanswer(sin(2 * pi))
    sin(2 * pi)
    ## [1] -2.449294e-16
```

The output should automatically be copied to your clipboard to be pasted into an answer.

### `sodput`

```
> sodput(mtcars, rows=1:6)
                                                                                  
     mtcars <- structure(list(mpg = c(21, 21, 22.8, 21.4, 18.7, 18.1), cyl = c(6, 
         6, 4, 6, 8, 6), disp = c(160, 160, 108, 258, 360, 225), hp = c(110,      
         110, 93, 110, 175, 105), drat = c(3.9, 3.9, 3.85, 3.08, 3.15,            
         2.76), wt = c(2.62, 2.875, 2.32, 3.215, 3.44, 3.46), qsec = c(16.46,     
         17.02, 18.61, 19.44, 17.02, 20.22), vs = c(0, 0, 1, 1, 0, 1),            
             am = c(1, 1, 1, 0, 0, 0), gear = c(4, 4, 4, 3, 3, 3), carb = c(4,    
             4, 1, 1, 2, 1)), .Names = c("mpg", "cyl", "disp", "hp", "drat",      
         "wt", "qsec", "vs", "am", "gear", "carb"), row.names = c("Mazda RX4",    
         "Mazda RX4 Wag", "Datsun 710", "Hornet 4 Drive", "Hornet Sportabout",    
         "Valiant"), class = "data.frame")  
```

The output should automatically be copied to your clipboard to be pasted into a question or an answer.

--------------------

## Known Limitations

- The features to read and write to the clipboard on Linux may be buggy. Be sure you have `xclip` installed. 
- When you select data to be used with `soread`, you must ensure that you fully select the last line; failing to do so would lead to your dataset being truncated by one row.
