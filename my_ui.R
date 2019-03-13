library("shiny")
library("ggplot2")
library("tidyr")

source('wrangle3.R')

my_ui <- fluidPage(
  titlePanel('Final Project'),

  mainPanel(
    tabsetPanel(type = "tabs",
                tabPanel(
                  'Introduction',
                  includeHTML('./www/pages/introduction.html')
                ),
                tabPanel(
                  "Freshman Courses",
                  sidebarLayout(
                    sidebarPanel(
                      selectInput(inputId = 'q1_select', label = 'Subsection', 
                                  choices = c('Introduction', 'Computer Science', 'Business', 'Conclusion'), 
                                              selected = 'Introduction'), br(),
                      
                      conditionalPanel("input.q1_select == 'Computer Science' || input.q1_select == 'Business'",
                                       selectInput(inputId = 'q1_type', label = 'Type', choices = c('Type 1', 'Type 2'),
                                                   selected = 'Type 1'))
                    ),
                    mainPanel(
                      htmlOutput(outputId = 'q1_page'), br(),
                      conditionalPanel("input.q1_select == 'Computer Science' || input.q1_select == 'Business'",
                        htmlOutput(outputId = 'q1_subsec')
                      )
                    )
                  )
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
                    p("This graph displays the top 10 departments at the University of Washington 
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
                  selectInput(
                    inputId = "select_school_q3",
                    label = "Select a school",
                    choices = c("University of Washington", "Virginia Tech"),
                    selected = "University of Washington"
                  ),
                  conditionalPanel(
                    "input.select_school_q3 == 'University of Washington'",
                    p("We couldn't find any consistent link between the amount of sections  
                      a professor teaches versus the average GPA students in their classes receive.
                      Interestingly enough, four out of the six subject areas we examined at the 
                      University of Washington showed higher average GPAs for professors teaching one 
                      section in the quarter, while only one out of the five subject areas we examined
                      at Virginia Tech showed a higher average GPA for professors teaching one section 
                      in the quarter. This goes to show that professors can handle teaching multiple 
                      sections as long as they aren't overwhelmed."),
                    plotOutput("uw_graph_q3")
                    ),
                  conditionalPanel(
                    "input.select_school_q3 == 'Virginia Tech'",
                    p("We couldn't find any consistent link between the amount of sections a 
                      professor teaches versus the average GPA students in their classes receive.
                      Interestingly enough, four out of the six subject areas we examined at the 
                      University of Washington showed higher average GPAs for professors teaching one 
                      section in the quarter, while only one out of the five subject areas we examined
                      at Virginia Tech showed a higher average GPA for professors teaching one section 
                      in the quarter. This goes to show that professors can handle teaching multiple 
                      sections as long as they aren't overwhelmed."),
                    plotOutput("vt_graph_q3")
                    )
                  ),
                tabPanel("Class Size",
                         sidebarPanel(selectInput(
                           inputId = "subject", 
                           label = "Pick a Department:",            
                           choices = c("All Departments", "Math", "Science", "English", "Social Science"),
                           selected = "All Departments"
                         )),
                         
                         mainPanel(
                           titlePanel("Class Size"),
                           plotOutput("q4plot"),
                           p("Typically, as class size increased, the average GPA decreased. This suggests 
                             that class size and GPA are negatively correlated. We can see the effect of class 
                             size most significantly within the math department with a major drop in the average 
                             GPA from a class of less than 25 students to a class of 25-50 students. Most other 
                             departments see a steady decrease in the average GPA as the class size increases, 
                             with some notably larger drops. English, although decreasing slightly, sees very 
                             little change in the average GPA despite its class size. "), 
                           br(),
                           p("The decreasing average GPA could be the result of multiple factors. Often times, 
                             larger classes are general introduction courses and can then be used as “weed-out” classes 
                             for particular majors. This means these larger courses may be graded more harshly or made 
                             more difficult to differentiate top students in those subjects. On top of this, many intro 
                             level courses are required for a lot majors but are not necessarily the focus of the major 
                             and must just be taken as a course prerequisite. This may lead to lower motivation from 
                             students to do exceptionally well in the course, in turn producing lower average GPA’s. 
                             Finally, students in larger classes may have a more difficult time receiving help in these 
                             courses, with so many students for just the one teacher. This could then result in a lower 
                             average GPA.")
                           )
                    )

    )
  )
)

