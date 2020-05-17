---
title: "CodeBook for Final Project in Coursera's Getting and Cleaning Data Course"
author: "Gill Collier"
date: "17/05/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
## R Markdown
This is an R Markdown document which describes the codebook for the Final Project in Coursera's Getting and Cleaning Data Course.
The README.md explains the background to the project.
The final data set in this code book is the file called "ProjectData.txt" in this repository.
The run_analysis.R script takes the raw data from the website and carries out a series of data transformations detailed below to produce the final data file.

Data

The data was downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
The data was extracted and saved in the folder called "UCI HAR Dataset"

The first row contains the name of the variables. 

Variables

features = features.txt (561 obs.. of 2 variables) - embedded accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz

activities = activities.txt (6 obs. of 2 variables) - activities performed - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

subject_test = test/subject_test.txt (2947 obs. of 1 variable) - 30% of the volunteers selected as test subjects
x_test = test/x_test.txt (2947 obs. of 561 variables) - test data
y_test = test/y_test.txt (2947 obs. of 1 variable) - activity codes labels for test data

subject_train = train/subject_train.txt (7352 obs. of 1 variable) - 70% of the volunteers selected
x_train = train/x_train.txt (7352 obs. of 561 variables) - train data
y_train = train/y_train.txt (7352 obs. of 1 variable) - activity codes labels for test data

Transformations

The following transformations were applied to the source data:

1. The training and test sets were merged to create one data set.
- x_train and x_test was combined using rbind() into x_data (10299 obs. of 561 variables)
- y_train and y_test was combined using rbind() into y_data (10299 obs. of 1 variable)
- subject_train and subject_test was combined using rbind() into Subject_data (10299 obs. of 1 variable)
- Subject_data, y_data and x_data was combined using cbind() into Merged_data (10299 obs. of 563 variables)

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

A subset of Merged_data was created from the mean and standard deviation for each measurement called tidyData (10299 obs. of 88 variables)

3. Uses descriptive activity names to name the activities in the data set

The code column in tidyData was updated to show the activity associated with each code

4. Appropriately labels the data set with descriptive variable names. 

Column names in the tidyData were renamed
    "code" = "activity"
    "Acc" = "Accelerometer"
    "Gyro" = "Gyroscope"
    "BodyBody" = "Body"
    "Mag" = "Magnitude"
    "^t" = "Time"
    "^f" = "Frequency"
    "tBody" = "TimeBody"

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

ProjectData data file was created from summarising tidyData and exported as "ProjectData.txt"