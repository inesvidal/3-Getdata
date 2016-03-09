# Question 1
# The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of 
# Idaho using download.file() from here: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?
# 125, 238,262
# 236, 238, 262
# 403, 756, 798
# 25, 36, 45
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2")
if(!file.exists("q2")) {
    dir.create("q2")
}

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2/q2")
install.packages("RMySQL")
library(sqldf)
library(RMySQL)

file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(file_url, "./US_Comm_Survey", method = "curl")
date_downloaded <- date()
acs <- read.table("./US_Comm_Survey", header = TRUE, sep = ",")


# Question 2
# Using the jpeg package read in the following picture of your instructor into R 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
# -16776430 -15390165
# -14191406 -10904118
# -10904118 -10575416
# -15259150 -10575416
# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame? 
# 
# Original data sources: 
#     http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats
# 189 matches, 13th country is Spain
# 234 matches, 13th country is St. Kitts and Nevis
# 190 matches, 13th country is Spain
# 190 matches, 13th country is St. Kitts and Nevis
# 189 matches, 13th country is St. Kitts and Nevis
# 234 matches, 13th country is Spain
# Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# 30, 37
# 23, 30
# 23, 45
# 133.72973, 32.96667
# 23.966667, 30.91304
# 32.96667, 91.91304
# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
# 0
# 5
# 12
# 13
