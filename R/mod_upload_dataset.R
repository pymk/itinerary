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
#' @importFrom dplyr mutate case_when
mod_upload_dataset_ui <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    shiny::fileInput(
      inputId = ns("upload_file"),
      label = "Upload CSV File",
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
      if (!is.null(file_oi())) {
        utils::read.csv(file_oi()$datapath, header = TRUE)
      }
    })
    
    dataset_mod <<- shiny::reactive({
      dataset_oi() |>
        dplyr::mutate(
          leave = as.Date(arrival) + as.numeric(duration_days),
          country = dplyr::case_when(
            country %in% c(
              "USA", "U.S.A.", "UniteD States"
            ) ~ "United States of America",
            country %in% c(
              "UK", "U.K.", "Scotland", "England"
            ) ~ "United Kingdom",
            TRUE ~ country
          )
        )
    })

  })
}

## To be copied in the UI
# mod_upload_dataset_ui("upload_dataset_1")

## To be copied in the server
# mod_upload_dataset_server("upload_dataset_1")
