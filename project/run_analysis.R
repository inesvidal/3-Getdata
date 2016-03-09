# This script provides a solution for the "Getting and cleaning data" project

# You will be required to submit: 
## 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations 
#or work that you performed to clean up the data called CodeBook.md. 
# You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  

setwd("/Users/inesv/Coursera/3-Getdata/project/")
if(!file.exists("data")) {
    dir.create("data")
}
setwd("/Users/inesv/Coursera/3-Getdata/project/data")

### Getting the dataset, and unzipping the files
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(file_url, "./getdata_projectfile_dataset.zip", method = "curl")
date_downloaded <- date()
# unziping the files
unzip ("getdata_projectfile_dataset.zip", exdir = "./dataset/", junkpaths = TRUE)

setwd("/Users/inesv/Coursera/3-Getdata/project/data/dataset")

# removing the descriptive files
descriptive_files <- c("features_info.txt", "README.txt")
file.copy(descriptive_files, "./..")
file.remove(descriptive_files)

# getting a list of all meaningful files
files <- list.files("./")

# loading all files in a list
data <- lapply(files,read.table)

# removing extensions to use then to identify the list items
files_no_ext <- gsub(".txt", "", files)

names(data) <- files_no_ext

### Merge the training and the test sets to create one data set.
# No inertial data considered, as discussed in 
# https://class.coursera.org/getdata-014/forum/thread?thread_id=30
# more detail in README.md

# merge X_train and X_test sets
dataset <- rbind(data$X_test, data$X_train)

colnames(dataset) <- data$features$V2

# merge y_train and y_test sets
activities <- rbind(data$y_test, data$y_train)
colnames(activities)<-"activity_id"

# merge subjet_train and subject_test sets
subjects <- rbind(data$subject_test, data$subject_train)
colnames(subjects) <- "subject"

# merge all three sets
dataset <- cbind(dataset, activities, subjects)

# introduce the variable names as column names

# clean current variable names to R naming conventions 
#(see ?make.names for additional info)
names <-names(dataset)
valid_column <- gsub("\\.\\.", ".", names)
valid_column_names <- make.names(valid_column, unique=TRUE, allow_ = TRUE)
colnames(dataset) <- valid_column_names

# To be able to run "dplyr" functions
library(dplyr)
table<- tbl_df(dataset)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Keep only columns whose names contain "mean" or "std", 
# in addition to subject and activity
table <- select(table, grep("mean", colnames(table)), 
                grep("std", colnames(table)), subject, activity_id)

# arrange the activity information
activity_detail <- data$activity_labels
colnames(activity_detail) <- c("id", "activity")

# Uses descriptive activity names to name the activities in the data set
table <- merge(table, activity_detail, by.x = "activity_id", by.y = "id")

# Appropriately labels the data set with descriptive variable names. 
# All columns have appropriate names from previous steps
# Remove activity_id column, it provides the same information than the
# activity column, replicated data
tidy_data <- select(table, -activity_id)

# From the data set in step 4, create a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

averages_tidy_dataset <- tidy_data %>%
    group_by (activity, subject) %>%  # group by activity and subject
    summarise_each(funs(mean))        # calculate averages for all columns except the ones we are grouping by

# upload your data set as a txt file created with write.table() using row.name=FALSE
write.table(averages_tidy_dataset, "./averages_dataset.txt", row.name = FALSE)
# the file can be loaded as read.table("./averages_dataset.txt")
