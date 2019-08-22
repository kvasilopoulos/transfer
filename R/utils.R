has_pkg <- function(pkg) {
  pkg %in% loadedNamespaces()
}

build_file <- function(url) {
  new_file <-  sub(".*/", "", url)
  paste0("./", new_file)
}

is_zip <- function(x) {
  sub(".*\\.", "", x) == "zip"
}

is_dir <- function(x) {
  res <- file.info(x)
  res$isdir
}

alphanumeric_zip_id <- function(n) {
  let <- do.call(paste0, replicate(2, sample(letters, n, TRUE), FALSE))
  num <- sprintf("%04d", sample(9999, n, TRUE))
  let2 <- sample(letters, n, TRUE)
  paste0("file", let, num, let2, ".zip")
}

bundle_zip <- function(file) {
  temp <- alphanumeric_zip_id(1)
  zip::zipr(temp, file)
  temp
}

assert_valid_file <- function(x) {
  if (!file.exists(x)) {
    stop("file does not exist", call. = FALSE)
  }
}
