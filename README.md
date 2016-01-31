# README

## Coursera Course Project - Getting and Cleaning Data

####################################################
#### GETTING AND CLEANING DATA - Course Project 
####################################################

##### *Anand Gupta*

The code 'run_analysis.R' helps combine two data sources in the excercise and retreive a tidy data set wit respect to specified criteria.

The original data 'Human Activity Recognition Using Smartphones Data Set' comes from the UCI Machine Learning Repositary and can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The algorythm of the code has been devised as below:

################
#### STEP 1 ####
#### Merge the training and test datasets into one ####
################


1. Importing features table

2. Importing TRAIN datasets - subject, x and y

3. Importing TEST datasets - subject, x and y

4. Renaming column names for x tables (TRAIN + TEST) to match activity descriptions in the FEATURES table

5. Renaming column names for Y tables (TRAIN + TEST) to 'activityID'

6. Combining x, y and subject tables for TEST and TRAIN

7. Merging tables for train and test


################
#### STEP 2 ####
#### Extract only the measurements on the mean and standard deviation for each measurement ####
################

*Please note that I have refrained from importing meanFreq() variables and have only captured mean() and std() variables*


1. Retreiving column numbers containg all STD DEVIATION Measures


2. Subsetting main dataset to have activityID, subjectID and all measures of standard deviation and mean


################
#### STEP 3 ####
#### Uses descriptive activity names to name the activities in the data set ####
################


1. Importing activity labels - to be used to replace activity ID's with descriptions in the main table


2. Replacing activityID's with activity descriptions as in the activity_labels.txt file

################
#### STEP 4 ####
#### Appropriately labels the data set with descriptive variable names. ####
################



################
#### STEP 5 ####
#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ####
################
