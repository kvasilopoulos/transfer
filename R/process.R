#' Browse to `url`
#'
#' This function takes you to the url.
#'
#' @inheritParams tf_download
#' @export
tf_browse <- function(url) {
  view_url(url)
}

view_url <- function(x, open = interactive()) {
  if (open) {
    utils::browseURL(x)
  }
  invisible(x)
}

#' Get the content
#'
#' This function accesses the content of the file.
#'
#' @param file Access the content of the local file that are connected with the link.
#' @export
tf_content <- function(file) {
  attr(file, "content")
}

process_reponse <- function(x, ...) {
  process <- run("curl", args = x, ...)
  process$stdout
}


