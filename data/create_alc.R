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
joinby =  c("school","sex","age","address","famsize","Pstatus","Medu",
            "Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, 
                       by = joinby, suffix = c(".math", ".por"))
print(nrow(math_por)) # 382 students
names(math_por)
str(math_por)

# We create a new data frame based on joined by columns
alc <- select(math_por, one_of(joinby))

# Not joined columns
notjoined_columns <- colnames(math)[!colnames(math) %in% joinby]

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  # if numeric
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { 
    alc[column_name] <- select(two_columns, 1)[[1]]
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)
glimpse(alc)

write.table(alc, file = "alc.txt")
