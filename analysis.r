library('dplyr')
library('tidyr')
library('ggplot2')

uw_grades <- read.csv('data/uw_grades_class.csv', stringsAsFactors = F) %>% 
  mutate(
    Course_Code = paste(Subject, Course)
  )

vt_grades <- read.csv('data/vt_grades_class.csv', stringsAsFactors = F) %>% 
  mutate(
    Course_Code = paste(Subject, Course)
  )


# ----------------------------------------------------
### General intro class analysis
uw_int <- uw_grades %>% 
  filter(Course < 200)

vt_int <- vt_grades %>% 
  filter(Course < 2000)

uw_sum <- data.frame(
  School = 'UW',
  Min = round( min(uw_int$GPA), 2 ),
  Q1 = round( quantile(uw_int$GPA, 0.25), 2),
  Med = round( median(uw_int$GPA), 2 ),
  Q3 = round( quantile(uw_int$GPA, 0.75), 2 ),
  Max = round( max(uw_int$GPA), 2 )
)

vt_sum <- data.frame(
  School = 'VT',
  Min = round( min(vt_int$GPA), 2 ),
  Q1 = round( quantile(vt_int$GPA, 0.25), 2),
  Med = round( median(vt_int$GPA), 2),
  Q3 = round( quantile(vt_int$GPA, 0.75), 2 ),
  Max = round( max(vt_int$GPA), 2 )
)

summary <- rbind(uw_sum, vt_sum)
rownames(summary) <- summary$School

box_summary <- ggplot(data = summary) +
  geom_boxplot(aes(ymin = Min, lower = Q1, middle = Med, upper = Q3, ymax = Max, x = School, color = School), 
               stat = 'identity') +
  labs(y = 'GPA (4.0 Scale)', color = 'Institution') +
  ggtitle('Grade Distributions of All Introductory Courses\nat University of Washington and Virginia Tech') +
  scale_color_manual(values = c('#8856a7', '#99000d')) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank())

present_sum <- summary %>% 
  select( -School )
  
# ---------------------------------------------------------------
grab_relevant <- function(data, classes) {
  result <- data %>% 
    filter(
      Course_Code %in% classes
    ) %>% 
    group_by(Subject) %>% 
    summarize(
      As = sum(As),
      Bs = sum(Bs),
      Cs = sum(Cs),
      Ds = sum(Ds),
      Fs = sum(Fs),
      GPA = mean(GPA),
      N = sum(N)
    )
    
}

plot_summary <- function(dat1, dat2, target) {
  combine <- rbind(dat1, dat2) %>% 
    group_by( School ) %>% 
    summarize(
      'Average GPA' = mean(GPA)
    )
  
  result <- ggplot(data = combine) +
    geom_col(mapping = aes(x = School, y = `Average GPA`, fill = School)) +
    scale_fill_manual(values = c('#8856a7', '#99000d')) +
    labs(y = 'Average GPA Across All Courses (4.0 scale)',
         title = paste('Average GPAs for', target, 'Students')) +
    theme(axis.title.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text.x = element_blank()) +
    ylim(0, 4) + 
    geom_text(aes(x = School, y = `Average GPA`, label = round(`Average GPA`, digits = 2)),
              position = position_stack(vjust = 1.1, revers = F), size = 4)
  
  result
}

plot_dist <- function(dat1, dat2, target) {
  result <- ggplot(data = rbind(dat1, dat2)) +
    geom_col(mapping = aes(Subject, GPA, fill = School), position = 'dodge') +
    scale_fill_manual(values = c('#8856a7', '#99000d')) +
    labs(y = 'GPA (4.0 Scale)', title = paste('GPAs for', target, 'Students by Subject')) +
    ylim(0, 4)
  
  result
}

#-------------------------------------------------------------------------

#-----------------------------------------------------
### Computer Science (Engineering degrees)

## Type 1 CS

# UW - Math 124, CS 142, ENGL 111/121/131
uw_cs1 <-grab_relevant(uw_grades, c('MATH 124', 'CSE 142', 'ENGL 111', 'ENGL 121', 'ENGL 131', 'CHEM 142')) %>% 
  mutate(
    School = 'UW'
  )

# VT - Chem 1035:1045, ENGL 1105:1106, MATH 1225, CS 114
vt_cs1 <- grab_relevant(vt_grades, c('CHEM 1035', 'CHEM 1045', 'ENGL 1105', 'ENGL 1106', 'MATH 1225', 'CS 1114')) %>% 
  mutate(
    School = 'VT',
    Subject = sub('^CS$', 'CSE', Subject)
  ) 
  
# Graph
cs1 <- plot_dist(uw_cs1, vt_cs1, 'Type 1 CS')
cs1_sum <- plot_summary(uw_cs1, vt_cs1, 'Type 1 CS')

## Type 2 CS

# UW - Math 126, CS 143, ENGL 111/121/131
uw_cs2 <- grab_relevant(uw_grades, c('MATH 126', 'CSE 143', 'ENGL 111', 'ENGL 121', 'ENGL 131', 'PHYS 123')) %>% 
  mutate(
    School = 'UW'
  )

# VT - MATH 2204, PHYS 2305, ENGE 1216, CS 2104
vt_cs2 <- grab_relevant(vt_grades, c('MATH 2204', 'PHYS 2305', 'CS 2104', 'ENGL 1106', 'ENGL 1105')) %>% 
  mutate(
    School = 'VT',
    Subject = sub('^CS$', 'CSE', Subject)
  )

# Graph stuff
cs2 <- plot_dist(uw_cs2, vt_cs2, 'Type 2 CS')
cs2_sum <- plot_summary(uw_cs2, vt_cs2, 'Type 2 CS')

#------------------------------------------------------

### Business Degrees (any) (BABA)

## Type 1 Business

# UW - Math 124, ENGL 111/121/131, ECON 200, PSYCH 101
uw_bu1 <- grab_relevant(uw_grades, c('MATH 124', 'ENGL 111', 'ENGL 121', 'ENGL 131', 'ECON 200', 'PSYCH 101')) %>% 
  mutate(
    School = 'UW'
  )

# VT - ACIS 1504, MATH 1525, ENGL 1105, Psyc 1004
vt_bu1 <- grab_relevant(vt_grades, c('MATH 1525', 'ENGL 1105', 'ENGL 1106', 'PSYC 1004', 'ECON 2005')) %>% 
  mutate(
    School = 'VT',
    Subject = sub('^PSYC$', 'PSYCH', Subject)
  )

bu1 <- plot_dist(uw_bu1, vt_bu1, 'Type 1 Business')
bu1_sum <- plot_summary(uw_bu1, vt_bu1, 'Type 1 Business')

## Type 2 Business

# UW - ACCTG 215, ENGL 111/121/131, MGMT 200
uw_bu2 <- grab_relevant(uw_grades, c('ACCTG 215', 'ENGL 111', 'ENGL 121', 'ENGL 131', 'ECON 300')) %>% 
  mutate(
    School = 'UW'
  )

# VT - ACIS 1504, psyc 1004, comm 2004, bit 2405
vt_bu2 <- grab_relevant(vt_grades, c('ACIS 1504', 'ENGL 1105', 'ENGL 1106', 'ECON 3104')) %>% 
  mutate(
    School = 'VT',
    Subject = sub('^ACIS$', 'ACCTG', Subject)
  )

bu2 <- plot_dist(uw_bu2, vt_bu2, 'Type 2 Business')
bu2_sum <- plot_summary(uw_bu2, vt_bu2, 'Type 2 Business')