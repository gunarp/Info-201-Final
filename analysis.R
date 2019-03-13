library("dplyr")
library("knitr")
library("stringr")
library("tidyr")
library("ggplot2")

# How does the GPA for courses taught by Professors instructing multiple courses
# compare to those instructing a single class?

# import uw and vt  Autumn 2015 grades data
uw_grades <- read.csv("data/uw_grades.csv", stringsAsFactor = FALSE) %>%
  filter(Term == "20154 (Autumn 2015)")
vt_grades <- read.csv("data/vt_grades.csv", stringsAsFactor = FALSE)

# New row called department created by removing the number and section letter
# from Course_Number in uw grades
uw_grades$department <- word(uw_grades$Course_Number, 1)


# adds a column that indicates whether the professor teaches multiple sections
uw_grades <- uw_grades %>%
  group_by(Primary_Instructor) %>%
  mutate(num_of_sections = sum(Primary_Instructor == Primary_Instructor)) %>%
  mutate(teaches_multiple = num_of_sections > 1)

vt_grades <- vt_grades %>%
  group_by(Instructor) %>%
  mutate(num_of_sections = sum(Instructor == Instructor)) %>%
  mutate(teaches_multiple = num_of_sections > 1)

# Summarize the average GPA data grouped by department/subject and teaching
# multiple courses. Filters for MATH, CSE, CHEM, PHYS, BIO, and INFO courses
summary_uw_grades <- uw_grades %>%
  group_by(department, teaches_multiple) %>%
  summarize(avg_gpa = mean(Average_GPA)) %>%
  filter(department == "MATH" |
    department == "CSE" |
    department == "CHEM" |
    department == "PHYS" |
    department == "BIOL" |
    department == "INFO")

summary_vt_grades <- vt_grades %>%
  group_by(Subject, teaches_multiple) %>%
  summarize(avg_gpa = mean(GPA)) %>%
  filter(Subject == "MATH" |
    Subject == "CS" |
    Subject == "CHEM" |
    Subject == "PHYS" |
    Subject == "BIOL")


# bar graph of uw grades
uw_graph <- ggplot(summary_uw_grades,
  mapping = aes(x = department, y = avg_gpa, fill = teaches_multiple)
) +
  geom_col(position = "dodge") +
  labs(
    title = "University of Washington Average Departmental Grades for 
    Professors Teaching a Single Course vs Multiple Courses",
    x = "Subject",
    y = "Grade Point Average",
    fill = "Teaches Multiple Courses"
  ) +
  scale_x_discrete(labels = c(
    "Biology", "Chemistry", "Computer Science",
    "Informatics", "Math", "Physics"
  ))
plot(uw_graph)

# bar graph of vt grades
vt_graph <- ggplot(summary_vt_grades,
  mapping = aes(x = Subject, y = avg_gpa, fill = teaches_multiple)
) +
  geom_col(position = "dodge") +
  labs(
    title = "Virginia Teach Average Subject Grades for Professors 
       Teaching a Single Course vs Multiple Courses",
    x = "Subject",
    y = "Grade Point Average",
    fill = "Teaches Multiple Courses"
  ) +
  scale_x_discrete(labels = c(
    "Biology", "Chemistry", "Computer Science",
    "Math", "Physics"
  ))

plot(vt_graph)
