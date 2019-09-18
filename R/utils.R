has_pkg <- function(pkg) {
  pkg %in% loadedNamespaces()
}

wd_path <- function(url, wd) {
  if (is.null(wd)) {
    path <- url
  }else{
    path <- file.path(wd, url)
  }
  path
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
  paste0("transfer", let, num, let2, ".zip")
}

#' @importFrom zip zipr zip_list
bundle_zip <- function(file, path) {
  temp <- alphanumeric_zip_id(1)
  filepath <- wd_path(temp, path)
  zip::zipr(filepath, wd_path(file, path))
  list(
    temp = temp,
    filepath = filepath
  )
}

assert_valid_filename <- function(x) {
  if (!file.exists(x)) {
    stop("file does not exist", call. = FALSE)
  }
}
