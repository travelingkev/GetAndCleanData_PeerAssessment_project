# Getting and Cleaning Data
## Course Project

This project contains a codebook in _CodeBook.md_ and _run\_analysis.R_ file.

The CodeBook file contains a description of the data and transformations done to it by the _run\_analysis.R_ script

The _run\_analysis.R_ file works when sourced in a folder containing the data from the [UCI HAR dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The Code does the following: 
	- reads the metadata from features.txt and activity_labels.txt
	- For both the training and the test data:
		- loads the X, Y, and Subject files
		- applies column names to the X data
		- replaces activity names with activity labels
		- selects a subset of the Mean and Standard Deviation information
		- binds the activity and subject labels to the measurement data
	- Once this is done for the training and test data, the two sets are merged to one
	- generates a dataset getting the mean of all values for each subject and activity
	- writes the output to a text file

