require(shiny)||install.packages('shiny')
require(ggplot2)||install.packages("ggplot2")
require(tidyr)||install.packages("tidyr")
require(dplyr)||install.packages("dplyr")
require(stringr)||install.packages("stringr")


source("my_ui.R")
source("my_server.R")

shinyApp(ui = my_ui, server = my_server)

