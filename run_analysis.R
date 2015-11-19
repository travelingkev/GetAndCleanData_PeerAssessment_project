# From the project description:

# By Kevin Bailey
# For: Coursera Getting and Cleaning Data

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
# Data descritption at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Program was written based on data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Project Requirements:
#	1. Merges the training and the test sets to create one data set.
#	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#	3. Uses descriptive activity names to name the activities in the data set
#	4. Appropriately labels the data set with descriptive variable names. 
#	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 	-- Per the project instructions, this should output the data set as a txt file created with write.table() using row.name=FALSE

## Project Assumptions:
#	Data is available in the local working directory



# Read metadata from file:
library('data.table')
col_names = fread('features.txt')$V2 # names for fields in "X" tables
activities = fread('activity_labels.txt')$V2 # Text description of "Y" tables


# Load training data
library('dplyr')
training_superset <- fread('train/X_train.txt')
names(training_superset) <- col_names
subjects <- fread('train/subject_train.txt')
names(subjects) <- 'subject_ID'
activity_raw <- fread('train/y_train.txt')


# update activity info to use descriptive labels
activity_names <- activities[activity_raw[[1]]]
names(activity_names) <- 'activity'

# subset training data
subset <- select(training_superset, matches('-std\\()|-mean\\()'))
training_set <- cbind(activity_names, subjects, subset)


# merge activity and test subject info

# Load test data
testing_superset <- fread('test/X_test.txt')
names(testing_superset) <- col_names
subjects <- fread('test/subject_test.txt')
names(subjects) <- 'subject_ID'
activity_raw <- fread('test/y_test.txt')

# update activity info to use descriptive labels
activity_names <- activities[activity_raw[[1]]]
names(activity_names) <- 'activity'

# subset testing data
subset <- select(testing_superset, matches('-std\\()|-mean\\()'))
testing_set <- cbind(activity_names, subjects, subset)


full_set <- rbind(testing_set, training_set)

# Generate Tidy set of data
tidy_set <- group_by(full_set, activity_names, subject_ID) %>% summarize_each(funs(mean))

# Write output file to working directory
write.table(tidy_set, 'tidy_set.txt', row.names = FALSE)

