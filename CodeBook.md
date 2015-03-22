# Process and variables description

As shown in (https://support.rstudio.com/hc/en-us/articles/200711843-Working-Directories-and-Workspaces)[this article] in RStudio support website, the script begins cleaning workspace.

Script expects the original raw data files in a directory called ```dataset```, extracted directly from downloaded zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

	dataset
		|- activity_labels.txt
		|- features.txt
		|- test
			|- subject_test.txt
			|- X_test.txt
			|- y_test.txt
		|- train
			|- subject_train.txt
			|- X_train.txt
			|- y_train.txt


To load data, the script use next temp variables:

* ```activity_labels``` contains ID and names of activities.
* ```features``` contains ID and description of measured features in the studio. Theese description are used as column names when load data from *X_train* and *X_test* files.

From train directory:

* ```xtrain``` contains data from *X_train* file.
* ```ytrain``` contains data from *Y_train* file.
* ```strain``` contains data from *subject_train*.

From test directory:

* ```xtest``` contains data from *X_test* file.
* ```ytest``` contains data from *Y_test* file.
* ```stest``` contains data from *subject_test*.

Before merge train and test data, it's necessary bind data by columns.

* ```train``` contains all train data merged by columns.
* ```test``` contains all test data merged by columns.
* ```dataset``` contains final dataset merging train and test data by rows .

Once we have a unique dataset, we select only columns with means and std deviation and two additional columns with activities and subjects IDs. Create two variables:

* ```cols``` contains positions of columns to select
* ```mean_std``` stores subsets of data from original dataset

To set activity descriptive names to original dataset, the script merge ```dataset``` with ```activity_labels``` using ```ActId``` adding a new column ```ActName``` to resulting dataset.

* ```named``` contains original dataset with an additional column with descriptive activity names.
