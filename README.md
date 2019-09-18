
<!-- README.md is generated from README.Rmd. Please edit that file -->

# transfer

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/kvasilopoulos/transfer.svg?branch=master)](https://travis-ci.org/kvasilopoulos/transfer)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/kvasilopoulos/transfer?branch=master&svg=true)](https://ci.appveyor.com/project/kvasilopoulos/transfer)
<!-- badges: end -->

The goal of {transfer} is to utilize the power of
[transfer.sh](https://transfer.sh) through R.  is a website and not a
script, which helps users to share files from the command-line an
efficient way. It won’t required any additional software to work except
pre-installed application such as curl.

## Install

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kvasilopoulos/transfer")
```

## Example

This is a basic example which shows you how to use {transfer}:

``` r
library(transfer)
```

To upload either file or folder you can easily use the name of the file
and the path where the file is located, if it is not in the working
directory. In case of a folder or multiple files `tf_upload` will bundle
all contents and zip it into a single file. Then it will upload the zip
and delete the zip that was created locally.

## File

``` r
tf_upload("file.txt", path = "inst/examples")
#>  --- Uploaded: transfer.sh --- 
#> https://transfer.sh/2NaO8/file.txt
```

## Folder

``` r
tf_upload("folder", path = "inst/examples")
#>  --- Uploaded: transfer.sh --- 
#> https://transfer.sh/94xcf/transfersi7519w.zip
```
