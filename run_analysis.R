################################################################################
#
#   Coursera Getting and Cleaning Data Course Project
#   Tony G. Bolaño
#   March 2015
#
#   This script will perform the following steps on the UCI HAR Dataset 
#   downloaded from 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
#   1. Merge the training and the test sets to create one data set.
#   2. Extract only the measurements on the mean and standard deviation 
#      for each measurement. 
#   3. Use descriptive activity names to name the activities in the data set
#   4. Appropriately label the data set with descriptive activity names. 
#   5. Creates a second, independent tidy data set with the average of each 
#      variable for each activity and each subject. 
#
################################################################################

# First we cleanup workspace
# ref. https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces

rm(list = ls())

# read features and activity labels

activity_labels <- read.table("dataset/activity_labels.txt", header = F, col.names = c("ActId","ActName"))
features <- read.table("dataset/features.txt", header = F, col.names = c("FeatId","FeatDesc"))

# read train data
# features contains names for columns on xtrain data
xtrain <- read.table("dataset/train/X_train.txt", header = F, col.names = features[,2])
ytrain <- read.table("dataset/train/y_train.txt", header = F, col.names = c("ActId"))
strain <- read.table("dataset/train/subject_train.txt", header = F, col.names = c("SubjectId"))

# read test data
xtest <- read.table("dataset/test/X_test.txt", header = F, col.names = features[,2])
ytest <- read.table("dataset/test/y_test.txt", header = F, col.names = c("ActId"))
stest <- read.table("dataset/test/subject_test.txt", header = F, col.names = c("SubjectId"))



################################################################################
# 1. Merge the training and the test sets to create one data set.
################################################################################

# bind columns in train and test data

train <- cbind(strain, ytrain, xtrain)
test <- cbind(stest, ytest, xtest)

# bind rows in train and test data in one dataset

dataset <- rbind(train, test)



################################################################################
# 2. Extract only the measurements on the mean and standard deviation for
#    each measurement.
################################################################################

# Obtain cols positions of IDs, mean and std data
# and select this data from dataset

cols <- grep("ActId|SubjectId|(mean|std)\\.", colnames(dataset))
mean_std <- dataset[,cols]



################################################################################
# 3. Use descriptive activity names to name the activities in the data set
################################################################################

# Add a column ActName merging original dataset with activiti labels using
# activity ID

named <- merge(dataset, activity_labels, by.x = "ActId", by.y = "ActId", all.x = T)



################################################################################
# 4. Appropriately label the data set with descriptive activity names. 
################################################################################



################################################################################
# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
################################################################################
