#' Upload a file to \code{transfer.sh}
#'
#' Share files with a URL Upload up to 10 GB Files stored for 14 days
#'
#' @param filename File to be uploaded
#' @param path Path to find the file (combined with filenamed)
#' @param max_downloads Number of max downloads downloaded from the provided link.
#' @param max_days Number of days that the link is going be live. Maximum to 14.
#' @param spinner Whether to show a reassuring spinner while the process is running.
#' @param ... Further arguments paseed to \code{\link[processx]{run}}.
#'
#' @return a \code{transfer.sh} link.
#'
#' @export
#' @examples
#' \dontrun{
#'
#' # Upload current directory
#' x <- tf_upload(".")
#'
#' # See the content send to \code{transfer.sh}
#' tf_content(x)
#'
#' # Open the link in browser
#' tf_browse(x)
#'
#' # Download
#' tf_download(x)
#' }
tf_upload <- function(filename,  path = NULL, max_downloads = NULL, max_days = NULL,
                      spinner = TRUE, ...) {
  request <- build_request_up(filename, .path = path, .max_dl = max_downloads,
                              .max_days = max_days, ...)
  process_reponse_up(request, spinner = spinner, ...)
}

build_request_up <- function(.file, .path, .max_dl, .max_days, ...) {

  assert_valid_filename(wd_path(.file, .path)) # needs full path for file.info
  url_file <- build_url(.file, .path)
  path_file <- build_file(url_file)
  arg_max_dl <- build_max_dl(.max_dl)
  arg_max_days <- build_max_days(.max_days)

  req <- c(arg_max_dl, arg_max_days, "--upload-file", path_file, url_file)
  attr(req, "zip") <- attr(url_file, "need_zip")
  attr(req, "content") <- attr(url_file, "content")
  attr(req, "path") <- .path
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

build_url <- function(file, wd) {
  url_remote <- "https://transfer.sh"
  need_zip <- length(file) > 1 || is_dir(wd_path(file, wd))  # needs full path for checks
  if (need_zip) {
    file <- bundle_zip(wd_path(file, wd)) # creates zip in wd
  }
  url <- file.path(url_remote, file)
  attr(url, "need_zip") <- need_zip
  attr(url, "content") <- if (need_zip) zip::zip_list(file)$filename else file
  url
}

#' @export
print.transfer_up <- function(x, ...) {
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

