## 1
# Name: Hari Adhikari
# Date: 07/11/2018
# Here we work on data wrangling for linear regression.

##2
# Read data from website, separated by "\s" and header=TRUE
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(learning2014)
#[1] 183  60
# This file has 183 rows and 60 columns

names(learning2014)
summary(learning2014)

##3 
#d_sm Seeking Meaning ~ D03 + D11 + D19 + D27
#d_ri Relating Ideas ~ D07 + D14 + D22 + D30
#d_ue Use of Evidence ~ D06 + D15 + D23 + D31

#su_lp Lack of Purpose ~ SU02 + SU10 + SU18 + SU26
#su_um Unrelated Memorizing ~ SU05 + SU13 + SU21 + SU29
#su_sb Syllabus-boundness ~ SU08 + SU16 + SU24 + SU32

#st_os Organized Studying ~ ST01 + ST09 + ST17 + ST25
#st_tm Time Management ~ ST04 + ST12 + ST20 + ST28

#Deep Deep Approach ~ d_sm + d_ri + d_ue
#Surf Surface approach ~ su_lp + su_um + su_sb
#Stra Strategic approach ~ st_os + st_tm

# Lets create a new column by combining some columns
learning2014["deep"] <- rowMeans(learning2014[,c("D03", "D11", "D19", "D27", 
                                                 "D07", "D14", "D22","D30",
                                                 "D06", "D15", "D23","D31")],  dims=1)

learning2014["surf"] <- rowMeans(learning2014[,c("ST01", "ST09", "ST17", "ST25", 
                                             "ST04", "ST12", "ST20","ST28")], dims =1)
                                          
learning2014["stra"] <- rowMeans(learning2014[, c("ST01","ST09", "ST17", "ST25",
                                                  "ST04", "ST12", "ST20", "ST28")], dims=1)
                           
names(learning2014)
# Subset learning2014  
learning2014 <- learning2014[, c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")]

# Subset learning2014 (remove rows which have Points==0)  
learning2014 <- learning2014[which(learning2014$Points!=0), ]
# Check the dimension of the learning2014
dim(learning2014)                                   
# 1] 166  7
# Now the number of rows is 166 and 7 columns

##4
# Write refined learning2014 as csv in the data folder in IODS project
write.csv(learning2014, "C:/Users/hari/Documents/GitHub/IODS-project/data/learning2014.csv", row.names = F)

learning2014readagain <- read.table("C:/Users/hari/Documents/GitHub/IODS-project/data/learning2014.csv", sep=",", header=T)

