
# Question 3 Data _____________________________________________________________

# import uw and vt  Autumn 2015 grades data
uw_grades <- read.csv("data/uw_grades.csv", stringsAsFactor = FALSE) %>%
  filter(Term == "20154 (Autumn 2015)") 

vt_grades <- read.csv("data/vt_grades.csv", stringsAsFactor = FALSE) %>% 
  rename(Subject = 'Subject')

# New row called Subject created by removing the number and section letter
# from Course_Number in uw grades
uw_grades$Subject <- word(uw_grades$Course_Number, 1)


# adds a column that indicates whether the professor teaches multiple sections
uw_grades <- uw_grades %>%
  group_by(Primary_Instructor) %>%
  mutate(num_of_sections = sum(Primary_Instructor == Primary_Instructor)) %>%
  mutate(teaches_multiple = num_of_sections > 1)

vt_grades <- vt_grades %>%
  group_by(Instructor) %>%
  mutate(num_of_sections = sum(Instructor == Instructor)) %>%
  mutate(teaches_multiple = num_of_sections > 1)

# Summarize the average GPA data grouped by Subject/subject and teaching
# multiple courses. Filters for MATH, CSE, CHEM, PHYS, BIO, and INFO courses
summary_uw_grades <- uw_grades %>%
  group_by(Subject, teaches_multiple) %>%
  summarize(avg_gpa = mean(Average_GPA)) %>%
  filter(Subject == "MATH" |
           Subject == "CSE" |
           Subject == "CHEM" |
           Subject == "PHYS" |
           Subject == "BIOL" |
           Subject == "INFO")

summary_vt_grades <- vt_grades %>%
  group_by(Subject, teaches_multiple) %>%
  summarize(avg_gpa = mean(GPA)) %>%
  filter(Subject == "MATH" |
           Subject == "CS" |
           Subject == "CHEM" |
           Subject == "PHYS" |
           Subject == "BIOL")

# Added a school column and combined the data frames together
summary_uw_grades$school <- "Univeristy of Washgington"
summary_vt_grades$school <- "Virginia Tech"
summary_all_grades <- rbind(summary_uw_grades, summary_vt_grades)

# _____________________________________________________________________________
