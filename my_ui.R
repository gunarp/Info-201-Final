library("shiny")
library("ggplot2")
library("tidyr")

my_ui <- shinyUI(navbarPage(
  "App Title",
  tabPanel("Class Size",
           sidebarPanel(selectInput(
             inputId = "subject", 
             label = "Pick a Department:",            
             choices = c("All", "Math", "Science", "English", "Social Science"),
             selected = "All"
           )),
           
           mainPanel(
             "Class Size",
             plotOutput("q4plot"),
             p("Typically, as class size increased, the average GPA decreased. This suggests that class size 
               and GPA are negatively correlated. We can see the effect of class size most significantly within 
               the math department with a major drop from a class of less than 25 students to a class of 25-50 
               students. Most other departments see a steady decrease in the average GPA as the class size 
               increases. English, although decreasing slightly, sees very little change in the average GPA 
               compared to the other departments."), 
             br(),
             p("The decreasing average GPA could be the result of multiple factors. Easier classes will typicaly 
               have higher GPA's and often times larger classes are general introduction courses and are 
               therefore easier than their smaller, more specified counterparts. Larger courses may also 
               have more resources (Teachers, Teaching Assistants, Office Hours, Study Centers) for them, 
               making it easier to do well in class. Additionally, the range of student abilities within 
               larger classes is typically much wider, limiting the scope of the class and the material covered. 
               This in turn lowers expectations and leads to easier assignments, midterms and finals.")
           )
           ),
  tabPanel("Hardest Classes",
           sidebarPanel(),
           mainPanel()
           )
  ))

