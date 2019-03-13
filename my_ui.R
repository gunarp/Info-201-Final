library("shiny")
library("ggplot2")
library("tidyr")

my_ui <- fluidPage(
  titlePanel(strong("Final Project")),

  mainPanel(
    tabsetPanel(
      type = "tabs",
      tabPanel(
        "Freshman Courses",
        p("blah blah blah")
      ),
      tabPanel(
        "Easiest Departments",
        p("blah blah blah")
      ),
      tabPanel(
        "Hardest Departments",
        p("blah blah blah")
      ),
      tabPanel(
        "Types of Teachers",
        selectInput(
          inputId = "select_school_q3",
          label = "Select the school",
          choices = summary_all_grades$school
        ),
        select = "University of Washington",
        plotOutput("graph_q3"),

        p("We couldn't find any consistent link between the amount of sections a 
professor teaches versus the average GPA students in their classes receive.
Interestingly enough,four out of the six subject areas we examined at the 
University of Washington showed higher average GPAs for professors teaching one 
section in the quarter, while only one out of the five subject areas we examined
at Virginia Tech showed a higher average GPA for professors teaching one section 
in the quarter. This goes to show that professors can handle teaching multiple 
          sections as long as they aren't overwhelmed.")
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
