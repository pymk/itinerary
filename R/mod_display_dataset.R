#' display_dataset UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom reactable renderReactable reactableOutput
#' @importFrom shinycssloaders withSpinner
mod_display_dataset_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::uiOutput(ns("preview_title")),
    shinycssloaders::withSpinner(reactable::reactableOutput(ns("table")))
  )
}

#' display_dataset Server Functions
#'
#' @noRd
mod_display_dataset_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$preview_title <- shiny::renderUI({
      if (is.null(file_oi())) {
        return(NULL)
      }
      shiny::strong("Preview")
    })

    output$table <- reactable::renderReactable({
      if (is.null(file_oi())) {
        return(NULL)
      }
      printable(dataset_oi())
    })
  })
}

## To be copied in the UI
# mod_display_dataset_ui("display_dataset_1")

## To be copied in the server
# mod_display_dataset_server("display_dataset_1")
