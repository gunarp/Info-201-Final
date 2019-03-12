library('dplyr')
library('knitr')
library('stringr')
library('ggplot2')
uw_grades <- read.csv('./data/uw_grades.csv', stringsAsFactors = F)

vt_grades <- read.csv('./data/vt_grades.csv', stringsAsFactors = F)

uw_grades <- filter(uw_grades, Term == "20154 (Autumn 2015)")

# Adds a department column for the uw grade data
uw_grades$department <- word(uw_grades$Course_Number, 1)

# Converts Virgina Tech grades from percentages into number of students 
vt_grades <- vt_grades %>% 
  select("ï..Subject", Course_Title, GPA, As, Bs, Cs, Ds, Fs, Number_of_students)

vt_grades$As <- round(vt_grades$As * vt_grades$Number_of_students / 100)
vt_grades$Bs <- round(vt_grades$Bs * vt_grades$Number_of_students / 100)
vt_grades$Cs <- round(vt_grades$Cs * vt_grades$Number_of_students / 100)
vt_grades$Ds <- round(vt_grades$Ds * vt_grades$Number_of_students / 100)
vt_grades$Fs <- round(vt_grades$Fs * vt_grades$Number_of_students / 100)
vt_grades$Average_GPA <- vt_grades$GPA
vt_grades <- vt_grades %>% 
  select("ï..Subject", Course_Title, As, Bs, Cs, Ds, Fs, Average_GPA)
# Consolidates UW grades into rounded letter grades 
uw_grades$As <- uw_grades$A + uw_grades$A_Minus
uw_grades$Bs <- uw_grades$B + uw_grades$B_Minus + uw_grades$B_Plus
uw_grades$Cs <- uw_grades$C + uw_grades$C_Minus + uw_grades$C_Plus
uw_grades$Ds <- uw_grades$D + uw_grades$D_Minus + uw_grades$D_Plus
uw_grades$Fs <- uw_grades$F
uw_grades <- uw_grades %>% 
  select(department, Course_Title, As, Bs, Cs, Ds, Fs, Average_GPA)

# Converts all blank data into 0 in both UW and VT data 
uw_grades[is.na(uw_grades)] <- 0
vt_grades[is.na(vt_grades)] <- 0
names(vt_grades)[names(vt_grades) == "ï..Subject"] <- "department"

# Remove pass/fail classes and seminar classes from both data sets
uw_grades_highest <- uw_grades %>% 
  filter(As != 0 & Average_GPA >= 3.8) 

# Remove pass/fail classes and seminar classes
# Finds the highests GPAs and lowest GPA departments from each school 
vt_grades_highest <- vt_grades %>% 
  filter(As != 0 & Average_GPA >= 3.8) 

uw_grades_lowest <- uw_grades %>% 
  filter(As != 0 & Average_GPA <= 2.8) 

vt_grades_lowest <- vt_grades %>% 
  filter(Average_GPA <= 2.8) 

# Remove duplicate classes from each department and grabs a count of each unique class for each department
uw_distinct_high <- uw_grades_highest %>% 
  group_by(department) %>% 
  summarise(n_distinct(Course_Title))
names(uw_distinct_high)[names(uw_distinct_high) == "n_distinct(Course_Title)"] <- "Number of Classes"

uw_distinct_high <- arrange(uw_distinct_high, desc(`Number of Classes`))

# Extracts the top 6 high GPA departments for UW
uw_distinct_high <- uw_distinct_high[1:6,]

vt_distinct_high <- vt_grades_highest %>% 
  group_by(department) %>% 
  summarise(n_distinct(Course_Title))
names(vt_distinct_high)[names(vt_distinct_high) == "n_distinct(Course_Title)"] <- "Number of Classes"

vt_distinct_high <- arrange(vt_distinct_high, desc(`Number of Classes`))

# Extracts the top 6 highest GPA departments for VT
vt_distinct_high <- vt_distinct_high[1:6,]

# Extracts the top 6 lowest GPA departments for UW
uw_distinct_low <- uw_grades_lowest %>% 
  group_by(department) %>% 
  summarise(n_distinct(Course_Title))
names(uw_distinct_low)[names(uw_distinct_low) == "n_distinct(Course_Title)"] <- "Number of Classes"
uw_distinct_low <- arrange(uw_distinct_low, desc(`Number of Classes`))
uw_distinct_low <- uw_distinct_low[1:6,]

# Extracts the top 6 lowest GPA departments for 
vt_distinct_low <- vt_grades_lowest %>% 
  group_by(department) %>% 
  summarise(n_distinct(Course_Title))
names(vt_distinct_low)[names(vt_distinct_low) == "n_distinct(Course_Title)"] <- "Number of Classes"

vt_distinct_low <- arrange(vt_distinct_low, desc(`Number of Classes`))

vt_distinct_low <- vt_distinct_low[1:6,]

names(vt_distinct_low)[names(vt_distinct_low) == "department"] <- "Department"
names(vt_distinct_high)[names(vt_distinct_high) == "department"] <- "Department"
names(uw_distinct_low)[names(uw_distinct_low) == "department"] <- "Department"
names(uw_distinct_high)[names(uw_distinct_high) == "department"] <- "Department"

uw_high_avg <- ggplot(data = uw_distinct_high) +
  geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#8856a7") +
  labs(
    title = "Departments at UW with High Class GPAs (GPA >= 3.8)", 
    x = "Departments", 
    y = "Number of Classes"
  )


vt_high_avg <- ggplot(data = vt_distinct_high) +
  geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#99000d") +
  labs(
    title = "Departments at VT with High Class GPAs (GPA >= 2.8)", 
    x = "Departments", 
    y = "Number of Classes"
  )

uw_low_avg <- ggplot(data = uw_distinct_low) +
  geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#8856a7") +
  labs(
    title = "Departments at UW with Low Class GPAs (GPA <= 2.8)", 
    x = "Departments", 
    y = "Number of Classes"
  )

vt_low_avg <- ggplot(data = vt_distinct_low) +
  geom_col(mapping = aes(x = Department, y = `Number of Classes`), fill = "#99000d") +
  labs(
    title = "Departments at VT with Low Class GPAs (GPA <= 2.8)", 
    x = "Departments", 
    y = "Number of Classes"
  )

