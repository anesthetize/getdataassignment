####################################################
#### GETTING AND CLEANING DATA - Course Project ####
####################################################

## Anand Gupta
## 22nd January 2016

## runAnalysis.R


################
#### STEP 1 ####
#### Merge the training and test datasets into one ####
################

#Set Working Directory where the UCI HAR Dataset has been extracted; please download and extract data from :
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
setwd("/Users/GreyBook/R/UCI HAR Dataset")

#Importing features table
features <- read.table('features.txt')
colnames(features) <- c('activityID','activityDesc')

# Importing TRAIN datasets - subject, x and y
subject_train <- read.table('train/subject_train.txt')
X_train <- read.table('train/X_train.txt')
Y_train <- read.table('train/y_train.txt')
colnames(subject_train) <- 'subjectID'

# Importing TEST datasets - subject, x and y
subject_test <- read.table('test/subject_test.txt')
X_test <- read.table('test/X_test.txt')
Y_test <- read.table('test/y_test.txt')
colnames(subject_test) <- 'subjectID'

#Renaming column names for x tables (TRAIN + TEST) to match activity descriptions in the FEATURES table
colnames(X_train) <- features$activityDesc
colnames(X_test) <- features$activityDesc

#Renaming column names for Y tables (TRAIN + TEST) to 'activityID'
colnames(Y_train) <- 'activityID'
colnames(Y_test) <- 'activityID'

#Combining x, y and subject tables for TEST and TRAIN
test_main <- cbind(Y_test,subject_test,X_test)
train_main <- cbind(Y_train, subject_train, X_train)

#Merging tables for train and test
main1 <- rbind(train_main,test_main)


################
#### STEP 2 ####
#### Extract only the measurements on the mean and standard deviation for each measurement ####
################

#### Please note that I have refrained from importing meanFreq() variables and have only captured mean() and std() variables ####


#Retreiving column numbers containg all STD DEVIATION Measures
main_cols_std <- grep("std\\()",colnames(main1))

#Retreiving column numbers containg all MEAN Measures
main_cols_mean <- grep("mean\\()",colnames(main1))

#Subsetting main dataset to have activityID, subjectID and all measures of standard deviation and mean
main1 <- main1[c(1,2,main_cols_std,main_cols_mean)]


################
#### STEP 3 ####
#### Uses descriptive activity names to name the activities in the data set ####
################


#Importing activity labels - to be used to replace activity ID's with descriptions in the main table
activity_lbls <- read.fwf('activity_labels.txt',sep = " ", widths=20)
colnames(activity_lbls) <- c("activityID","activityDesc")

#Replacing activityID's with activity descriptions as in the activity_labels.txt file
for(i in 1:6){
  main1$activityID <- gsub(activity_lbls$activityID[i],activity_lbls$activityDesc[i],main1$activityID)
}


################
#### STEP 4 ####
#### Appropriately labels the data set with descriptive variable names. ####
################

colnames(main1) <- gsub("std\\()","Std",colnames(main1)) #Replacing 'std()' with 'Std'
colnames(main1) <- gsub("mean\\()","Mean",colnames(main1)) #Replacing 'mean()' with 'Mean'
colnames(main1) <- gsub("^(t)","time-",colnames(main1)) #Replacing starting 't' with 'time-'
colnames(main1) <- gsub("^(f)","freq-",colnames(main1)) #Replacing starting 'f' with 'freq-'
colnames(main1) <- gsub("Mag-","Magnitude-",colnames(main1)) #Replacing'Mag' with 'Magnitude'



################
#### STEP 5 ####
#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ####
################

tidydata <- aggregate(main1[,!(colnames(main1) %in% c("activityID","subjectID"))],by=list(activityID = main1$activityID, subjectID = main1$subjectID), FUN="mean")

write.table(tidydata,'tidydata.txt',sep='\t',row.names=T)
