
process_reponse <- function(x, ...) {
  process <- run("curl", args = x, ...)
  stop_for_error(process)
  process$stdout
}

stop_for_error <- function(x) {
  out <- gsub("\n", "", x$stdout)
  server_error <-
    c("Could not encode metadata",
      "Could not save metadata",
      "Could not retrieve file",
      "Error occurred copying to output stream")
  not_found <- "Not Found"
  error_code <-
    if (out == "Could not upload empty file") {
      400
    }else if (out == "File not found" ) {
      404
    }else if (out %in% server_error) {
      500
    }else if (out == not_found) {
      not_found
    }else{
      return()
    }
  error_type <-
    if (error_code == 400) {
      "400 Bad Request -"
    } else if (error_code == 404) {
      "404"
    } else if (error_code == 500) {
      "500 Internal Server Error"
    } else if (error_code == 520) {
      "Unknown  Error"
    }
  error_msg <- paste(error_type, out, sep = " / ")
  stop(error_msg, call. = FALSE)
}
