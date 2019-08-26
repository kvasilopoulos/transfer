#' Download from \code{transfer.sh}
#'
#' Using the link, download the file(s).
#'
#' @param url The url to download from.
#' @param name Whether to change the name of the download file into a
#' user-specified name.
#' @inheritParams tf_upload
#' @export
tf_download <- function(url = NULL, name = NULL, spinner = TRUE,  ...) {
  request <- build_request_down(url, name)
  process_reponse_down(request, spinner = spinner, ...)
}

build_request_down <- function(.url, .name) {
  file <- build_file(.url)
  c(url, "-o", .name)
}

process_reponse_down <- function(.args, ...) {
  proc <- process_reponse(x = .args, ...)
  file <- .args[3]
  attr(file, "zip") <- is_zip(file)
  attr(file, "content") <- if (is_zip(file)) zip::zip_list(file)$filename else file
  class(file) <- "transfer_down"
  file
}

#' @export
print.transfer_down <- function(x) {
  attributes(x) <- NULL
  cat(" --- Downloaded: transfer.sh --- \n")
  cat(x)
}
