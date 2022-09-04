#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  shiny::tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    shiny::tags$style("@import url(https://use.fontawesome.com/releases/v5.7.2/css/all.css);"),
    bs4Dash::dashboardPage(
      title = "DashboardPage",
      dark = NULL,
      header = bs4Dash::dashboardHeader(
        title = bs4Dash::bs4DashBrand(
          title = "{itinerary}",
          color = "secondary"
        )
      ),
      sidebar = bs4Dash::dashboardSidebar(
        elevation = 0,
        collapsed = TRUE,
        minified = FALSE,
        expandOnHover = FALSE,
        bs4Dash::sidebarMenu(
          bs4Dash::menuItem(
            text = "Dashboard",
            tabName = "dashboard",
            icon = shiny::icon("dashboard"),
            selected = TRUE
          )
        )
      ),
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(
            tabName = "dashboard",
            bs4Dash::box(
              title = "Upload the Itinerary Dataset",
              width = 12,
              shiny::fluidRow(
                shiny::column(
                  width = 3,
                  mod_template_message_ui("template_message_1"),
                  shiny::br(),
                  mod_upload_dataset_ui("upload_dataset_1")
                ),
                shiny::column(width = 9, mod_display_dataset_ui("display_dataset_1"))
              )
            ),
            mod_generate_map_ui("generate_map_1")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  golem::add_resource_path(
    prefix = "www",
    directoryPath = app_sys("app/www")
  )

  shiny::tags$head(
    golem::favicon(ext = "png"),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "itinerary"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
