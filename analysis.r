library('dplyr')
library('tidyr')
library('ggplot2')

uw_grades <- read.csv('data/uw_grades_class.csv', stringsAsFactors = F)
vt_grades <- read.csv('data/vt_grades_class.csv', stringsAsFactors = F)

#-----------------------------------------------------
### Computer Science (Engineering degrees)

## Type 1 CS

# UW - Math 124, CS 142, ENGL 111/121/131

# VT - Chem 1035:1045, ENGL 1105, MATH 1225, ENGR 1215

## Type 2 CS

# UW - Math 126, CS 143, ENGL 111/121/131

# VT - MATH 2204, PHYS 2305, ENGE 1216, CS 2104

#------------------------------------------------------
### Economics (Science degrees)

## Type 1 Econ

# UW - Math 124, Econ 200, ENGL 111/121/131

# VT - Econ 2005, Math 1225, Math 1114, ENGL 1105

## Type 2 Econ

# UW - Math 126, Econ 300, ENGL 111/121/131

# VT - Econ 3104, ACIS 1504, PSYC 1004

#-----------------------------------------------------
### Business Degrees (any) (BABA)

## Type 1 Business

# UW - Math 124, ENGL 111/121/131, ECON 200

# VT - ACIS 1504, MATH 1525, ENGL 1105, Psyc 1004

## Type 2 Business

# UW - ACCTG 215, ENGL 111/121/131, MGMT 200

# VT - ACIS 1504, psyc 1004, comm 2004, bit 2405
