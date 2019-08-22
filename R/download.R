build_request_down <- function(url) {
  file <- build_file(url)
  c(url, "-o", file)
}

tf_download <- function(url = NULL, spinner = TRUE, ...) {
  request <- build_request_down(url)
  process_reponse_down(request, spinner = spinner, ...)
}

process_reponse_down <- function(.args, ...) {
  proc <- process_reponse(x = .args, ...)
  file <- build_file(.args[1])
  attr(file, "zip") <- is_zip(file)
  attr(file, "content") <- if (is_zip(file)) zip::zip_list(file)$filename else file
  class(file) <- "transfer_down"
  file
}

print.transfer_down <- function(x) {
  attributes(x) <- NULL
  cat(" --- Downloaded: transfer.sh --- \n")
  cat(x)
}
