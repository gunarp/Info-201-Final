library("dplyr")
library("tidyr")
library("ggplot2")


virginia_tech <- read.csv("data/vt_grades.csv", stringsAsFactors = FALSE)

uw <- read.csv("data/uw_grades.csv", stringsAsFactors = FALSE)

uw <- uw %>% 
  filter(Term == "20154 (Autumn 2015)") %>% 
  select("Student_Count", "Average_GPA") 

uw_small <- uw %>% 
  filter(Student_Count < 25) %>% 
  mutate(Size = "Less than 25")

uw_medium <- uw %>% 
  filter(Student_Count > 25 & Student_Count < 50) %>% 
  mutate(Size = "25-50")

uw_large <- uw %>% 
  filter(Student_Count > 50) %>% 
  mutate(Size = "Greater than 50")

uw <- full_join(uw_small, uw_medium, by = c("Student_Count", "Average_GPA", "Size"))

uw <- full_join(uw, uw_large, by = c("Student_Count", "Average_GPA", "Size"))

uw_summary <- uw %>% 
  group_by(Size) %>% 
  summarize( Average_GPA = mean(Average_GPA)) %>% 
  mutate(School = "University of Washington")

virginia_tech <- virginia_tech %>% 
  filter( Number_of_students < 2000) %>% 
  select("Number_of_students", "GPA")

colnames(virginia_tech) <- c("Student_Count", "Average_GPA")

vt_small <- virginia_tech %>% 
  filter(Student_Count < 25) %>% 
  mutate(Size = "Less than 25")

vt_medium <- virginia_tech %>% 
  filter(Student_Count > 25 & Student_Count < 50) %>% 
  mutate(Size = "25-50")

vt_large <- virginia_tech %>% 
  filter(Student_Count > 50) %>% 
  mutate(Size = "Greater than 50")

virginia_tech <- full_join(vt_small, vt_medium, by = c("Student_Count", "Average_GPA", "Size"))

virginia_tech <- full_join(virginia_tech, vt_large, by = c("Student_Count", "Average_GPA", "Size"))

vt_summary <- virginia_tech %>% 
  group_by(Size) %>% 
  summarize( Average_GPA = mean(Average_GPA)) %>% 
  mutate(School = "Virginia Tech") 


combined_data <- full_join(uw_summary, vt_summary, by = c("Size", "Average_GPA", "School"))

positions <- c("Less than 25", "25-50", "Greater than 50")
ggplot(data = combined_data, aes(x = Size, y = Average_GPA, fill = School)) + 
  geom_bar(stat="identity", position=position_dodge()) +
  scale_x_discrete(limits = positions) +
  scale_fill_manual(values = c('#8856a7','#99000d')) +
  labs(title = "GPA Based on Class Size", y = "Average GPA") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave('q4.png',width=6, height=4,dpi=300)
  
                           