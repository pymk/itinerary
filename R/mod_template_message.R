#' template_message UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom utils write.csv
mod_template_message_ui <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    shiny::strong("Download Template"),
    shiny::br(),
    shiny::uiOutput(ns("data_issue")),
    shiny::uiOutput(ns("message"))
  )
}

#' template_message Server Functions
#'
#' @noRd
mod_template_message_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
    output$data_issue <- shiny::renderUI({
      if (is.null(file_oi())) {
        return(NULL)
      } else if (validate_dataset(dataset_oi()) != TRUE) {
        shiny::div(
          shiny::span(
            shiny::strong("The dataset you uploaded has issues."),
            shiny::br(),
            shiny::strong("Please download the CSV template."),
            shiny::br(),
            style = "color:#ec4e50"
          ),
          style = "text-align:left; color:lightgray; border:1px dashed; padding:1.1em; display:inline-block;"
        )
      } else {
        return(NULL)
      }
    })

    output$message <- shiny::renderUI({
      shiny::div(
        shiny::span(
          "Download this template and use it to to provide your itinerary data.",
          shiny::br(), shiny::br(),
          shiny::downloadButton(outputId = ns("template_download"), label = "Download"),
          style = "text-align:left; color:#4d4d4d"
        ),
        style = "text-align:left; color:lightgray; border:1px dashed; padding:1.1em; display:inline-block;"
      )
    })

    output$template_download <- shiny::downloadHandler(
      filename = function() {
        "itinerary_template.csv"
      },
      content = function(file) {
        utils::write.csv(itinerary::extrip, file, row.names = FALSE)
      }
    )
  })
}

## To be copied in the UI
# mod_template_message_ui("template_message_1")

## To be copied in the server
# mod_template_message_server("template_message_1")
