samsungdata
===========

Clean and Reshape Samsung Data for Getting and cleaning data course assignment


The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set.
For this purpose we have taken the Samsung Data set as a starting point. 

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

As part of this project we have taken the above mentioned data and performed the following operations on the same 

- Merged the training and the test sets to create one data set.
- Extracted only the measurements on the mean and standard deviation for each measurement
- Used descriptive activity names to name the activities in the data set
- Appropriately labeled the data set with descriptive variable names. 
- Created a second, independent tidy data set with the average of each variable for each activity and each subject.

You will find the following files in this repository

- run_analysis.R - This is the script that does the cleaning and reshaping of data as described above
- codeBook.md - Describing the variables, the data, and any transformations or work that was performed to clean up the data
