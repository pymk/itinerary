#' upload_dataset UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom utils read.csv
mod_upload_dataset_ui <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    shiny::fileInput(
      inputId = ns("upload_file"),
      label = "Choose CSV File",
      multiple = FALSE,
      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")
    )
  )
}

#' upload_dataset Server Functions
#'
#' @noRd
mod_upload_dataset_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns

    file_oi <<- shiny::reactive({
      input$upload_file
    })

    dataset_oi <<- shiny::reactive({
      utils::read.csv(file_oi()$datapath, header = TRUE)
    })
  })
}

## To be copied in the UI
# mod_upload_dataset_ui("upload_dataset_1")

## To be copied in the server
# mod_upload_dataset_server("upload_dataset_1")
