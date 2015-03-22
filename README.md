# Getting and Cleaning Data Course Project 

This repo host files of the Course project for _Getting and Cleaning Data_ in the _Data Scientist Specialization_ in Coursera by the Johns Hopkins University.

## Overview

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

that was included in the ```dataset``` folder.

## Project summary

Here is the summary of tasks from the project instructions:

You should create one R script called ```run_analysis.R``` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script you need set the dataset folder and run_analysis.R in the working directory. When you run the script using

```source("run_analysis.R")```

your environment were cleaned up and after the execution you get a bunch of dataframes and variables (for detailed info see ```CodeBook.md```) and a ```tidyData.txt``` with the means of variables labeled as means or standard deviations from de original datasource for each activity and each subject.

## Analysis details

First we cleanup workspace as you can read on
https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces

Then we read data from files:
 
* read features from features.txt
* read activity labels from activity_labels.tx
* read train data from X_train.txt using features to set column names, activities IDs from y_train.txt and subjects IDs from subject_train.txt
* read test data from X_test.txt using features to set column names, activities IDs from y_test.txt and subjects IDs from subject_test.txt

### 1. Merge the training and the test sets to create one data set.

First bind columns in train and test data using ```cbind``` and merge train data and test data using ```rbind``` to obtain one unified dataset.

### 2. Extract only the measurements on the mean and standard deviation for each measurement.

Obtain cols positions of IDs, mean and std data and select this data from dataset using ```grep``` command.
### 3. Use descriptive activity names to name the activities in the data set

Add a column ActName merging result dataset (mean_std) with activity labels using activity ID as join column with ```merge``` command.

### 4. Appropriately label the data set with descriptive activity names. 

With a for loop we make some replacements for column names. Mainly abbreviations fro full names, delete dots and convert to CamelCase.

### 5. Creates a second, independent tidy data set with the average of each  variable for each activity and each subject. 

Using ```aggregate``` function calculate means grouped by ActivityId and SubjectId and writes result to a file named ```tidyData.txt``` in the current working directory.

## Author

Antonio González Bolaño
March 2015