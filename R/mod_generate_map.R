#' generate_map UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import highcharter
#' @importFrom shiny NS tagList
#' @importFrom jsonlite fromJSON
#' @importFrom httr content GET
#' @importFrom shinycssloaders withSpinner
mod_generate_map_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shiny::uiOutput(ns("map_ui"))
  )
}

#' generate_map Server Functions
#'
#' @noRd
mod_generate_map_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    fxn_get_content <- function(url) {
      httr::content(httr::GET(url))
    }

    world_geo_json <- "https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json"
    world <- shiny::reactive({
      fxn_get_content(world_geo_json) |>
        jsonlite::fromJSON(simplifyVector = FALSE)
    })

    subtitle_text <- shiny::reactive({
      min <- min(dataset_mod()$arrival, na.rm = TRUE)
      max <- max(dataset_mod()$leave, na.rm = TRUE)
      paste0(format(as.Date(min), "%b %Y"), " - ", format(as.Date(max), "%b %Y"))
    })

    output$map <- highcharter::renderHighchart({
      highcharter::highchart() |>
        highcharter::hc_title(text = "Itinerary", align = "left") |>
        highcharter::hc_subtitle(text = subtitle_text(), align = "left") |>
        highcharter::hc_add_series_map(
          map = world(),
          df = dataset_mod(),
          value = "duration_days",
          joinBy = c("name", "country"),
          dataLabels = list(enabled = TRUE, format = "{point.country}")
        ) |>
        highcharter::hc_legend(title = list(text = "Duration (Days)")) |>
        highcharter::hc_colorAxis(stops = highcharter::color_stops()) |>
        highcharter::hc_mapNavigation(enabled = TRUE) |>
        highcharter::hc_tooltip(
          useHTML = TRUE,
          headerFormat = "",
          pointFormat = "Visiting {point.city} ({point.country})"
        )
    })


    output$map_ui <- shiny::renderUI({
      if (validate_dataset(dataset_oi()) == TRUE) {
        bs4Dash::box(
          title = "Map",
          width = 12,
          shinycssloaders::withSpinner(
            highcharter::highchartOutput(ns("map"))
          )
        )
      } else {
        return(NULL)
      }
    })
  })
}

## To be copied in the UI
# mod_generate_map_ui("generate_map_1")

## To be copied in the server
# mod_generate_map_server("generate_map_1")
