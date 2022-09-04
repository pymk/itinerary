#' Printable
#'
#' @description A generic print function using reactable package.
#'
#' @return Dataframe
#' @param x a dataframe
#'
#' @noRd
#' @importFrom reactable reactable colDef
#' @importFrom utils head
printable <- function(x, n = 10) {
  if (is.numeric(n)) {
    x <- head(x, n = n)
  } else if (n == "all") {
    x <- x
  }
  
  reactable::reactable(
    data = x,
    defaultColDef = reactable::colDef(
      headerStyle = list(background = "#f7f7f8")
    ),
    bordered = TRUE,
    highlight = TRUE,
    sortable = TRUE,
    showSortable = TRUE,
    filterable = FALSE,
    searchable = FALSE,
    showPageSizeOptions = FALSE,
    showPageInfo = FALSE,
    defaultPageSize = 10
  )
}
