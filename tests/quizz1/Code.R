setwd("/Users/inesv/Coursera/3-Getdata")
if(!file.exists("quizz1")) {
    dir.create("quizz1")
}
if(!file.exists("q1")) {
    dir.create("q1")
}
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q1")


##Quizz 1
# Question 1
if(!file.exists("q1")) {
    dir.create("q1")
}
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q1")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "./housing_survey", method = "curl")
date_downloaded <- date()
survey_data <- read.table("./housing_survey", header = TRUE, sep = ",")
over1M <- survey_data[survey_data$VAL > 23 & !is.na(survey_data$VAL),]
nrow(over1M)
#resultado = 53

# Question 2, 
# la respuesta NO es "Tidy data has no missing values."

#Question 3
if(!file.exists("q3")) {
    dir.create("q3")
}
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q3")
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(file_url, "./gas_acquisition", method = "curl")
date_downloaded <- date()
install.packages("xlsx")
library("xlsx")
gas_acq_data <- read.xlsx("./gas_acquisition", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
dat <- gas_acq_data
sum(dat$Zip*dat$Ext,na.rm=T) 

# LA RESPUESTA NO ES 0 --> EL CÓDIGO DE ARRIBA ESTÁ MAL
# El resultado es: 36534720

# Question 4
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q4")
if(!file.exists("q4")) {
    dir.create("q4")
}
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q4")
file_url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
install.packages("XML")
library("XML")
doc <- xmlTreeParse(file_url, useInternal = TRUE)
date_downloaded <- date()
rootNode <- xmlRoot(doc)
# zipcode 21231
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
length(zipcodes[zipcodes == "21231"])

# Resultado =127 --> OK

#Question 5
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1")
if(!file.exists("q5")) {
    dir.create("q5")
}
setwd("/Users/inesv/Coursera/3-Getdata/tests/quizz1/q5")
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(file_url, "./housing_survey", method = "curl")
date_downloaded <- date()
install.packages("data.table")
library("data.table")
data <- fread("./housing_survey")
# average value of the variable pwgtp15 broken down by sex
i <- 1000
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]}) # <-- da error
zero <- replicate(i, system.time(DT[,mean(pwgtp15),by=SEX])[1])
one <- replicate(i, system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[1])
two <- replicate(i, system.time(tapply(DT$pwgtp15,DT$SEX,mean))[1])
three <- replicate(i, system.time(mean(DT$pwgtp15,by=DT$SEX))[1]) # <-- no hace la media por géneros
four <- replicate(i, system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})[1])

zero_av = cumsum(zero) / seq_along(zero)
one_av = cumsum(one) / seq_along(one)
two_av = cumsum(two) / seq_along(two)
three_av = cumsum(three) / seq_along(three)
four_av = cumsum(four) / seq_along(four)

topY = max(zero_av, one_av, two_av, three_av, four_av) #making sure the y axis is the right height
lowY = min(zero_av, one_av, two_av, three_av, four_av) #making sure the y axis is the right height
plot(one_av, type="l", col="yellow", ylim=c(lowY,topY), xlab="distance", ylab="average time")
lines(two_av, col="red")
lines(three_av, col="blue")
lines(four_av, col="green")
lines(zero_av, col="black")

# Respuesta: sapply(split(DT$pwgtp15,DT$SEX),mean)
# > summary(zero_av)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.0004000 0.0006358 0.0006469 0.0006419 0.0006544 0.0010000 
# > summary(one_av)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.0004000 0.0004838 0.0004854 0.0004866 0.0004884 0.0010000 
# > summary(two_av)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.0007333 0.0008256 0.0008316 0.0008369 0.0008380 0.0020000 
# > summary(three_av)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.000e+00 4.937e-05 5.052e-05 5.083e-05 5.343e-05 6.061e-05 
# > summary(four_av)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.02120 0.02137 0.02138 0.02143 0.02140 0.05100 




# LA RESPUESTA NO ES "mean(DT$pwgtp15,by=DT$SEX)"
