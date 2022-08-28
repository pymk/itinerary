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
    shiny::uiOutput(ns("message"))
  )
}

#' template_message Server Functions
#'
#' @noRd
mod_template_message_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    ns <- session$ns
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
        utils::write.csv(extrip, file, row.names = FALSE)
      }
    )
  })
}

## To be copied in the UI
# mod_template_message_ui("template_message_1")

## To be copied in the server
# mod_template_message_server("template_message_1")
