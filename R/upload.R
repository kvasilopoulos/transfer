

build_max_dl <- function(x) {
  if (is.null(x)) return(NULL)
  arg <- paste("Max-Downloads:", x)
  c("-H", arg)
}

build_max_days <- function(x) {
  if (is.null(x)) return(NULL)
  arg <- paste("Max-Days:", x)
  c("-H", arg)
}

build_url <- function(file) {
  url_remote <- "https://transfer.sh"
  need_zip <- length(file) > 1 || is_dir(file)
  if (need_zip) {
    file <- bundle_zip(file)
  }
  url <- paste(url_remote, file, sep = "/")
  attr(url, "need_zip") <- need_zip
  attr(url, "content") <- if (need_zip) zip::zip_list(file)$filename else file
  url
}

build_request_up <- function(file, .max_dl, .max_days) {
  url_file <- build_url(file)
  path_file <- build_file(url_file)
  arg_max_dl <- build_max_dl(.max_dl)
  arg_max_days <- build_max_days(.max_days)
  req <- c(arg_max_dl, arg_max_days, "--upload-file", path_file, url_file)
  attr(req, "zip") <- attr(url_file, "need_zip")
  attr(req, "content") <- attr(url_file, "content")
  req
}

tf_upload <- function(file, max_downloads = NULL, max_days = NULL,
                      spinner = TRUE, ...) {
  request <- build_request_up(file, .max_dl = max_downloads, .max_days = max_days)
  process_reponse_up(request, spinner = spinner, ...)
}

#' @importFrom processx run
process_reponse_up <- function(.args, ...) {
  proc <- process_reponse(x = .args, ...)
  attributes(proc) <- attributes(.args)
  file <- .args[length(.args) - 1]
  if (is_zip(file)) {
    unlink(file)
  }
  class(proc) <- "transfer_up"
  proc
}

print.transfer_up <- function(x) {
  attributes(x) <- NULL
  cat(" --- Uploaded: transfer.sh --- \n")
  if (has_pkg("clipr"))
    clipr::write_clip(x)
  if (has_pkg("crayon"))
    x <- crayon::bgYellow(x)
  cat(x)
  if (has_pkg("clipr"))
    cat("\n --- Copied to clipboard ---")
}

