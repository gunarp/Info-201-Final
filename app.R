library("shiny")
library("ggplot2")
library("tidyr")
library("dplyr")
library("stringr")


source("my_ui.R")
source("my_server.R")

shinyApp(ui = my_ui, server = my_server)

