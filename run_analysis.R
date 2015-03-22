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
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for 
#      each measurement.  
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names.  
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

# Add a column ActName merging result dataset (mean_std) with activity labels
# using activity ID as join column

named <- merge(mean_std, activity_labels, by.x = "ActId", by.y = "ActId", all.x = T)



################################################################################
# 4. Appropriately label the data set with descriptive activity names. 
################################################################################

# get col names
names <- colnames(named)

# for each column apply some replacements
for (i in 1:length(names)) {
    # Acc - Accelerator
    names[i] <- gsub("Acc", "Accelerator", names[i])
    # Sometimes body is repeated
    names[i] <- gsub("Body|BodyBody", "Body", names[i])
    # Mag - Magnitude
    names[i] <- gsub("Mag","Magnitude", names[i])
    # Capitalize mean
    names[i] <- gsub("mean", "Mean", names[i])
    # std - Standard Deviation
    names[i] <- gsub("std", "StandardDeviation", names[i])
    # Gyro - Gyroscope
    names[i] <- gsub("Gyro", "Gyroscope", names[i])
    # Delete dots
    names[i] <- gsub("\\.", "", names[i])
    # t at first character means Time domain
    names[i] <- gsub("^(t)", "Time", names[i])
    # f at first character means Frequency domain (Fast Fourier Transform)
    names[i] <- gsub("^(f)", "Frequency", names[i])
}

# Apply new column names
colnames(named) <- names

# Rename some cols manually using dplyr library
library(dplyr)

named <- rename(named, ActivityName = ActName, ActivityId = ActId)

################################################################################
# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
################################################################################

# Create a temp variable (without Activity Name column)

temp <- named[,names(named) != 'ActivityName']

# Calculate means group by ActivityId and SubjectId

tidyMeans <- aggregate(temp[,names(temp) != c('ActivityId','SubjectId')], by=list(ActivityId=temp$ActivityId,SubjectId = temp$SubjectId),mean)

# Add Activity names column

tidyMeans <- merge(tidyMeans,activity_labels,by.x = "ActivityId", by.y = "ActId", all.x = T)

# Write data to file

write.table(tidyMeans, './tidyData.txt',row.names=FALSE)