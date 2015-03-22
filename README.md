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

## Author

Antonio González Bolaño
March 2015