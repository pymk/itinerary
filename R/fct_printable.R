#' Printable
#'
#' @description A generic print function using reactable package.
#'
#' @return Dataframe
#' @param x a dataframe
#'
#' @noRd
#' @importFrom reactable reactable colDef
printable <- function(x) {
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
