virginia_tech <- read.csv("data/vt_grades.csv", stringsAsFactors = FALSE) %>% 
  rename(
    Subject = 'Subject'
  )

uw <- read.csv("data/uw_grades.csv", stringsAsFactors = FALSE)

uw <- uw %>% 
  filter(Term == "20154 (Autumn 2015)") %>% 
  select("Course_Number", "Student_Count", "Average_GPA")

uw_small <- uw %>% 
  filter(Student_Count < 25) %>% 
  mutate(Size = "Less than 25")

uw_medium <- uw %>% 
  filter(Student_Count > 25 & Student_Count < 50) %>% 
  mutate(Size = "25-50")

uw_large <- uw %>% 
  filter(Student_Count > 50) %>% 
  mutate(Size = "Greater than 50")

uw <- full_join(uw_small, uw_medium, by = c("Student_Count", "Average_GPA", "Size", "Course_Number"))

uw <- full_join(uw, uw_large, by = c("Student_Count", "Average_GPA", "Size", "Course_Number"))

uw <- uw %>% 
  mutate(Subject = substring(Course_Number, 1, 4), School = "University of Washington") %>% 
  select("Subject", "Student_Count", "Size", "Average_GPA", "School")

virginia_tech <- virginia_tech %>% 
  filter( Number_of_students < 2000) %>% 
  mutate(School = "Virginia Tech") %>% 
  select("Subject", "Number_of_students", "GPA", "School")

colnames(virginia_tech) <- c("Subject", "Student_Count", "Average_GPA", "School")

vt_small <- virginia_tech %>% 
  filter(Student_Count < 25) %>% 
  mutate(Size = "Less than 25")

vt_medium <- virginia_tech %>% 
  filter(Student_Count > 25 & Student_Count < 50) %>% 
  mutate(Size = "25-50")

vt_large <- virginia_tech %>% 
  filter(Student_Count > 50) %>% 
  mutate(Size = "Greater than 50")

virginia_tech <- full_join(vt_small, vt_medium, by = c("Student_Count", "Average_GPA", "Size", "Subject", "School"))

virginia_tech <- full_join(virginia_tech, vt_large, by = c("Student_Count", "Average_GPA", "Size", "Subject", "School"))
