my_server <- function(input, output) {
  
  output$q1_page <- renderPrint({
    filename <- input$q1_select
    filename <- sub('Introduction', 'intro', filename)
    filename <- sub('Computer Science', 'cs', filename)
    filename <- sub('Business', 'bu', filename)
    filename <- sub('Conclusion', 'conc', filename)
    
    includeHTML(paste0('./www/pages/', filename, '.html'))
  })
  
  output$q1_subsec <- renderPrint({
    filename <- input$q1_select
    filename <- sub('Computer Science', 'cs', filename)
    filename <- sub('Business', 'bu', filename)
    
    type <- input$q1_type
    type <- substr(type, nchar(type), nchar(type))
    
    includeHTML(paste0('./www/pages/', filename, type, '.html'))
  })
}
