## Quizz 2

# Question 1
# Register an application with the Github API here https://github.com/settings/applications. 
#Access the API to get information on your instructors repositories (hint: this is the url you want 
#"https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. 
#What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.
# 2014-01-04T21:06:44Z
# 2013-08-28T18:18:50Z
# 2012-06-21T17:28:38Z
# 2013-11-07T13:25:07Z


setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2")
if(!file.exists("q1")) {
    dir.create("q1")
}

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2/q1")

library(httr)
library(httpuv)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url

myapp <- oauth_app("github",
                   key = "100b829ada7b67fcc081",
                   secret = "aa88fc5729dbbc7b8d0994b0f3c008197f3adafa")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

library(jsonlite)
stop_for_status(req)
json <- fromJSON(toJSON(content(req)))

subset(json, json$name == "datasharing", select = c("name", "created_at"))

# name           created_at
# 5 datasharing 2013-11-07T13:25:07Z






# Question 2
# The sqldf package allows for execution of SQL commands on R data frames. We will 
# use the sqldf package to practice the queries we might send with the dbSendQuery 
# command in RMySQL. Download the American Community Survey data and load it into an R object called
# acs
# 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
# sqldf("select * from acs where AGEP < 50")
# sqldf("select * from acs where AGEP < 50 and pwgtp1")
# sqldf("select pwgtp1 from acs")
# sqldf("select pwgtp1 from acs where AGEP < 50")

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

## Result --> sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
# sqldf("select unique * from acs")
# sqldf("select unique AGEP from acs")
# sqldf("select distinct AGEP from acs")
# sqldf("select AGEP where unique from acs")

# Result: # sqldf("select distinct AGEP from acs")

# Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
#     
#     http://biostat.jhsph.edu/~jleek/contact.html 
# 
# (Hint: the nchar() function in R may be helpful)
# 45 31 2 25
# 43 99 7 25
# 45 31 7 31
# 45 92 7 2
# 45 0 2 2
# 43 99 8 6
# 45 31 7 25

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2")
if(!file.exists("q4")) {
    dir.create("q4")
}

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2/q4")

file_url <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(file_url)

htmllines <- readLines(con, n = 100)
close(con)

# > nchar(htmllines[10])
# [1] 45
# > nchar(htmllines[20])
# [1] 31
# > nchar(htmllines[30])
# [1] 7
# > nchar(htmllines[100])
# [1] 25

# Question 5
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
# 
# (Hint this is a fixed width file format)
# 28893.3
# 36.5
# 35824.9
# 101.83
# 32426.7
# 222243.1

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2")
if(!file.exists("q5")) {
    dir.create("q5")
}

setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz2/q5")
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(file_url, "./sst", method = "curl")
data <- read.fwf("./sst", skip = 4, widths = c(15,4,4,9,4,9,4,9,4))
sum(data[,4])
# [1] 32426.7