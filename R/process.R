
tf_browse <- function(x) {
  view_url(x)
}

view_url <- function(x, open = interactive()) {
  if (open) {
    utils::browseURL(x)
  }
  invisible(x)
}

tf_content <- function(x) {
  attr(x, "content")
}

process_reponse <- function(x, ...) {
  process <- run("curl", args = x, ...)
  proc <- process$stdout
}


