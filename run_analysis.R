# Gill Collier - 10 May 2020
# Coursera: Getting and Cleaning Data - Week 4 Final Course Project

## The data linked to from the course website represent data collected from 
## the accelerometers from the Samsung Galaxy S smartphone. A full description 
## is available at the site where the data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## load packages and set working directory
library(dplyr)
setwd("./RStudio Projects/Coursera")

## download datafiles
fileName <- "UCI HAR Dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataPath = "UCI HAR Dataset"

if (!file.exists(fileName)) {
    download.file(fileUrl, fileName, mode = "wb")
}

if (!file.exists(dataPath)) {
    unzip(fileName) 
}

## Import datafiles
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## 1. Merges the training and the test sets to create one data set 
## for train, test and subject_test and add column names
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject_data, y_data, x_data)

## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 
tidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set
tidyData$code <- activities[tidyData$code, 2]

## 4. Appropriately labels the data set with descriptive variable names
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "Time", names(tidyData))
names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject
ProjectData <- tidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(ProjectData, "ProjectData.txt", row.name=FALSE)
