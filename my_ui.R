library("shiny")
library("ggplot2")
library("tidyr")

my_ui <- fluidPage(
  titlePanel(strong("Final Project")),
  
  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel(
                  'Introduction'
                ),
                tabPanel(
                  "Freshman Courses", 
                  includeHTML('major.html')
                ),
                tabPanel(
                  
                  "High GPA Departments", 
                  selectInput(inputId = "school_select_high", 
                              label = "School of Interest:", 
                              choices = c("University of Washington", "Virginia Tech"),
                              selected = "University of Washington"
                  ),
                  conditionalPanel(
                    "input.school_select_high == 'University of Washington'",
                    p("This graph displays the top 10 departments at the at the University of Washington 
                       where  a number of classes in each of these departments have an average GPA at or above a 3.8. 
                       From this graph the English department and Sociology departments have the most number
                       of classes with 20 or more classes where students got high averages."),
                    plotOutput("uw_high")
                  ),
                  conditionalPanel(
                    "input.school_select_high == 'Virginia Tech'",
                    p("This graph displays the top 10 departments at Virginia Tech where the
                      number of classes in each of these departments have an average GPA at or above a 3.8 and while 
                      none of the departments have more than 20 classes where students get high averages, 
                      the distribution is less as more than all 6 of the departments shown have more than
                      10 classes where the average GPA was or above a 3.8. However, for Virginia Tech, their 
                      top departments are Education Curriculum and Instruction and English. "),
                    plotOutput("vt_high")
                  )                  
                ),
                tabPanel(
                  "Low GPA Departments", 
                  selectInput(inputId = "school_select_low", 
                              label = "School of Interest:", 
                              choices = c("University of Washington", "Virginia Tech"),
                              selected = "University of Washington"
                  ), 
                  conditionalPanel(
                    "input.school_select_low == 'University of Washington'",
                    p("This graph shows the top 10 departments at the University of Washington where
                       the number of classes in each of these departments have an average GPA at or below a 2.8. 
                       In this graph, Math has the most amount of classes at 14 while the second highest is 
                       the Biology department which has 8 classes with a low average GPA. "),
                    plotOutput("uw_low")
                  ),
                  conditionalPanel(
                    "input.school_select_low == 'Virginia Tech'",
                    p("This graph shows the top 10 departments at Virgina Tech where the
                       number of classes in each of these departments have an average GPA at or below a 2.8.
                       In this graph the Math department and Electrical Computer Engineer department 
                       have the most amount of classes which has similarities to the UW data as the
                       Math department also had the highest number of classes with low GPAs. "),
                    plotOutput("vt_low")
                  )  
                ),
                tabPanel(
                  "Types of Teachers", 
                  p("blah blah blah")
                ),
                tabPanel(
                  "Class Size", 
                  img(src = "img/q4.png", width = 600, height = 400, alt = "Average GPA per class size per school"),
                  p("Both the University of Washington and Virginia Tech have decreasing average GPA's the larger the class size gets. This suggests that class size and GPA are negatively correlated. Although the average GPA drops for both schools as class size increases, the University of Washington had consistently higher averages for each class size, and didn't see as big of a gap between class sizes. From the smallest class size to the largest, the University of Washington only saw a .098 point drop in average GPA, while Virginia Tech saw a .272 point drop in average GPA."), 
                  br(),
                  p("The decreasing average GPA could be the result of multiple factors. Easier classes will typicaly have higher GPA's and often times larger classes are general introduction courses and are therefore easier than their smaller, more specified counterparts. Larger courses may also have more resources (Teachers, Teaching Assistants, Office Hours, Study Centers) for them, making it easier to do well in class. Additionally, the range of student abilities within larger classes is typically much wider, limiting the scope of the class and the material covered. This in turn lowers expectations and leads to easier assignments, midterms and finals.")
                  
                )
    )
  )
)

