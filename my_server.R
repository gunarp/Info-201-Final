source('wrangle3.R')
source('wrangle4.R')
source('wrangle2.R')

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

      # Renders a plot with the selected years in the x axis and the area in the y axis
  #if(input$school_select_high == "University of Washington") {

  output$uw_high <- renderPlot ({
    
    uw_high_plot <- ggplot(data = uw_distinct_high) +
      geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#8856a7") +
      labs(
        title = "Departments at UW with High Class GPAs (GPA >= 3.8)", 
        x = "Departments", 
        y = "Number of Classes"
      ) +
      theme(plot.title = element_text(hjust = 0.5)) 
    uw_high_plot
  })
 # } else {
  output$vt_high <- renderPlot ({
    
    vt_high_plot <- ggplot(data = vt_distinct_high) +
      geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#99000d") +
      labs(
        title = "Departments at VT with High Class GPAs (GPA >= 3.8)", 
        x = "Departments", 
        y = "Number of Classes"
      ) +
      theme(plot.title = element_text(hjust = 0.5)) 
    vt_high_plot
  })
#}
  output$uw_low <- renderPlot ({
    
    uw_low_plot <- ggplot(data = uw_distinct_low) +
      geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#8856a7") +
      labs(
        title = "Departments at UW with High Class GPAs (GPA <= 2.8)", 
        x = "Departments", 
        y = "Number of Classes"
      ) + 
      theme(plot.title = element_text(hjust = 0.5)) 
    uw_low_plot
  })
  output$vt_low <- renderPlot ({
    
    vt_low_plot <- ggplot(data = vt_distinct_low) +
      geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#99000d") +
      labs(
        title = "Departments at VT with High Class GPAs (GPA <= 2.8)", 
        x = "Departments", 
        y = "Number of Classes"
      ) +
      theme(plot.title = element_text(hjust = 0.5)) 
    vt_low_plot
  })
  
  output$q4plot <- renderPlot({
    if (input$subject == "Math"){
      uw_summary <- uw %>% 
        filter(Subject %in% c("MATH", "AMAT", "STAT")) %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "University of Washington")
      
      vt_summary <- virginia_tech %>% 
        filter(Subject %in% c("MATH", "STAT")) %>%
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "Virginia Tech")
    } else if (input$subject == "Science"){
      uw_summary <- uw %>% 
        filter(Subject %in% c("BIOL", "CHEM", "PHYS")) %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "University of Washington")
      
      vt_summary <- virginia_tech %>% 
        filter(Subject %in% c("BIOL", "CHEM", "PHYS")) %>%
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "Virginia Tech")
    } else if (input$subject == "English"){
      uw_summary <- uw %>% 
        filter(Subject == "ENGL") %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "University of Washington")
      
      vt_summary <- virginia_tech %>% 
        filter(Subject == "ENGL") %>%
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "Virginia Tech")
    } else if (input$subject == "Social Science"){
      uw_summary <- uw %>% 
        filter(Subject %in% c("COM ", "SOC ", "PSYC")) %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "University of Washington")
      
      vt_summary <- virginia_tech %>% 
        filter(Subject %in% c("COMM", "SOC ", "PSYC")) %>%
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "Virginia Tech")
    } else {
      uw_summary <- uw %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "University of Washington")
      
      vt_summary <- virginia_tech %>% 
        group_by(Size) %>% 
        summarize( Average_GPA = mean(Average_GPA)) %>% 
        mutate(School = "Virginia Tech")
    }
    
    combined_data <- full_join(uw_summary, vt_summary, by = c("Size", "Average_GPA", "School"))
    
    positions <- c("Less than 25", "25-50", "Greater than 50")
    ggplot(data = combined_data, aes(x = Size, y = Average_GPA, fill = School)) + 
      geom_bar(stat="identity", position=position_dodge()) +
      scale_x_discrete(limits = positions) +
      scale_fill_manual(values = c('#8856a7','#99000d')) +
      labs(title = paste0("GPA Based on Class Size for ", input$subject), y = "Average GPA") +
      theme(plot.title = element_text(hjust = 0.5)) 
  })
  
  output$graph_q3 <- renderPlot({
    summary_all_grades <- summary_all_grades %>%
      filter(school == input$select_school_q3)
    
    if (input$select_school_q3 == "University of Washington") {
      ggplot(data = summary_all_grades,
             mapping = aes(
               x = Subject,
               y = avg_gpa,
               fill = teaches_multiple
             )
      ) +
        geom_col(position = "dodge") +
        labs(
          title = "University of Washington Average Subjectal Grades for 
          Professors Teaching a Single Course vs Multiple Courses",
          x = "Subject",
          y = "Grade Point Average",
          fill = "Teaches Multiple Courses"
        ) +
        scale_x_discrete(labels = c(
          "Biology", "Chemistry", "Computer Science",
          "Informatics", "Math", "Physics"
        )) +
        scale_fill_manual(values = c("white", "black"))
    } else {
      ggplot(summary_all_grades,
             mapping = aes(
               x = Subject,
               y = avg_gpa,
               fill = teaches_multiple
             )
      ) +
        geom_col(position = "dodge") +
        labs(
          title = "Virginia Tech Average Subject Grades for Professors 
      Teaching a Single Course vs Multiple Courses",
          x = "Subject",
          y = "Grade Point Average",
          fill = "Teaches Multiple Courses"
        ) +
        scale_x_discrete(labels = c(
          "Biology", "Chemistry", "Computer Science",
          "Math", "Physics"
        )) +
        scale_fill_manual(values = c("white", "black"))
    }
    # bar_graph_q3
  })
  
}

