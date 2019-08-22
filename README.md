
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

This is a basic example which shows you how to solve a common problem:

``` r
library(transfer)
```

## Create Files and Directories to use in my examples

``` r
file.create("file.txt")
#> [1] TRUE
dir.create("folder")
file.create("zipfile.zip")
#> [1] TRUE
```

## File

``` r
tf_upload("file.txt")
#>  --- Uploaded: transfer.sh --- 
#> https://transfer.sh/6A3Rk/file.txt
```

## Folder

``` r
tf_upload("folder")
#>  --- Uploaded: transfer.sh --- 
#> https://transfer.sh/Ammd2/filerv4158g.zip
```

## Zip

``` r
tf_upload("zipfile.zip")
#>  --- Uploaded: transfer.sh --- 
#> https://transfer.sh/ReggU/zipfile.zip
```
