# Author: Hari Adhikari
# 13.11.2018
# Alcohol consumption by students and its affects on studies.
# Reference to the data sources
# https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

install.packages("dplyr")
library(dplyr)

setwd("C:/LocalData/adhihari/Github/IODS-project/data")
math=read.table("student-mat.csv",sep=";",header=TRUE)
por=read.table("student-por.csv",sep=";",header=TRUE)

# Structure and dimension of the data
# Structure
str(math); str(por)
# Dimension
dim(math); dim(por)

# Merge two data frame based on common columns and exclude those rows which do not fulfill those criteria
# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, 
                       by = c("school","sex","age","address","famsize","Pstatus","Medu",
                              "Fedu","Mjob","Fjob","reason","nursery","internet"), 
                       suffix = c(".math", ".por"))
print(nrow(math_por)) # 382 students
names(math_por)
str(math_por)


