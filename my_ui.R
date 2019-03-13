library("shiny")
library("ggplot2")
library("tidyr")

my_ui <- shinyUI(navbarPage(
  "App Title",
  tabPanel("Class Size",
           sidebarPanel(selectInput(
             inputId = "subject", 
             label = "Pick a department",            
             choices = c("Math", "Science", "English", "Social Science", "All"),
             selected = "All"
           )),
           
           mainPanel(
             "Class Size",
             plotOutput("q4plot"),
             p("Both the University of Washington and Virginia Tech have decreasing average GPA's the larger the class size gets. This suggests that class size and GPA are negatively correlated. Although the average GPA drops for both schools as class size increases, the University of Washington had consistently higher averages for each class size, and didn't see as big of a gap between class sizes. From the smallest class size to the largest, the University of Washington only saw a .098 point drop in average GPA, while Virginia Tech saw a .272 point drop in average GPA."), 
             br(),
             p("The decreasing average GPA could be the result of multiple factors. Easier classes will typicaly have higher GPA's and often times larger classes are general introduction courses and are therefore easier than their smaller, more specified counterparts. Larger courses may also have more resources (Teachers, Teaching Assistants, Office Hours, Study Centers) for them, making it easier to do well in class. Additionally, the range of student abilities within larger classes is typically much wider, limiting the scope of the class and the material covered. This in turn lowers expectations and leads to easier assignments, midterms and finals.")
           )
           ),
  tabPanel("Hardest Classes",
           sidebarPanel(),
           mainPanel()
           )
  ))

