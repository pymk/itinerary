#' Validate Dataset
#'
#' @description A function to validate uploaded dataset.
#'
#' @return Returns \code{TRUE} if dataset passes validation; returns an
#' error message otherwise.
#'
#' @noRd
#' @importFrom purrr map_df map_lgl
#' @importFrom dplyr select
validate_dataset <- function(x) {
  
  req_columns <- names(itinerary::extrip)
  
  world_map <- maps::world.cities |>
    dplyr::select(country = country.etc, city = name)
  
  other_names <- c(
    "U.S.A.",
    "U.K.",
    "Scotland",
    "England",
    "United States",
    "United States of America",
    "United Kingdom"
  )

  check_countries <- x$country %in% c(world_map$country, other_names)
  
  is_date <- function(date, date_format = "%Y-%m-%d") {
    tryCatch(!is.na(as.Date(date, date_format)), error = function(err) {
      FALSE
    })
  }

  is_integer_number <- function(number) {
    if (!is.na(number) & grepl("^\\d+$", number)) {
      tryCatch(as.numeric(number) %% 1 == 0, error = function(err) {
        FALSE
      })
    } else {
      return(FALSE)
    }
  }

  is_empty <- function(x) {
    x_df <- purrr::map_df(x, ~ is.na(.x) | nchar(.x) == 0)
    x_ls <- purrr::map_lgl(x_df, any)
    if ("TRUE" %in% x_ls) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }

  if (!all(req_columns %in% names(x))) {
    return("Error: required columns are not present or have typos.")
  } else if (!all(purrr::map_lgl(x$duration_days, ~ is_integer_number(.x)))) {
    return("Error: `duration_days` values should be numbers.")
  } else if (!all(is_date(x$arrival))) {
    return("Error: `arrival` values should be in YYYY-MM-DD format.")
  } else if (is_empty(x)) {
    return("Error: Rows cannot be left empty.")
  } else if (!all(check_countries)) {
    countries_not_found <- x$country[which(check_countries == FALSE)]
    return(paste0(
      "Error: Possible typo in country names: ",
      paste0(countries_not_found, collapse = ", ")
    ))
  } else {
    return(TRUE)
  }
}
