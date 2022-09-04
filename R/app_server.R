#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  mod_upload_dataset_server("upload_dataset_1")
  mod_template_message_server("template_message_1")
  mod_display_dataset_server("display_dataset_1")
  mod_generate_map_server("generate_map_1")
}
