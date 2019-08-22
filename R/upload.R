#' Upload a file to \code{transfer.sh}
#'
#' Share files with a URL Upload up to 10 GB Files stored for 14 days
#'
#' @param file the file to be uploaded
#' @param max_downloads number of max downloads
#' @param max_days number of days that the link is gonna be live. Maximum to 14.
#' @param spinner Whether to show a reassuring spinner while the process is running.
#' @param ... further arguments paseed to \code{\link[processx]{run}}
#'
#' @export
#' @examples
#' \dontrun{
#'
#' # Upload current directory
#' tf_upload(".")
#' }
tf_upload <- function(file,  max_downloads = NULL, max_days = NULL,
                      spinner = TRUE, ...) {
  request <- build_request_up(file, .max_dl = max_downloads, .max_days = max_days)
  process_reponse_up(request, spinner = spinner, ...)
}

build_request_up <- function(file, .max_dl, .max_days) {
  assert_valid_file(file)
  url_file <- build_url(file)
  path_file <- build_file(url_file)
  arg_max_dl <- build_max_dl(.max_dl)
  arg_max_days <- build_max_days(.max_days)
  req <- c(arg_max_dl, arg_max_days, "--upload-file", path_file, url_file)
  attr(req, "zip") <- attr(url_file, "need_zip")
  attr(req, "content") <- attr(url_file, "content")
  req
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

