# overflow 0.2-4

* Modified `soread` to allow skipping lines after header, for example when
using with outpt from a `tibble`.

# overflow 0.2-3

* `solast` added to capture the output from `.Last.value` along with the last 
expression from the history.

# overflow 0.2-1

* Added `sorandf` for creating random datasets.

# overflow 0.2-0

* Renamed package from 'oveRflow' to 'overflow'
* Renamed function `SOread`, `SOdput` and `tmp_install_packages to `soread` and 
  `sodput` and `sopkgs` for easier use.
* New function: SOdput - Sends `dput` to clipboard with assignment operator.
* readSO now strips out ## comments and leading whitespace.
* Bugfix - tmp_install_packages no longer overwrites libraries which are not 
  the base and user libraries.
* New function: tmp_install_packages - installs packages to a temporary library.
* Bugfix - readSO now works on Mac.

# overflow 0.1-0

* New function: readSO - reads in data from StackOverflow.
