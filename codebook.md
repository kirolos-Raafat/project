# Data:
The used data for the analysis represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
[link to the website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and the data :
[the compressed file for the data to be analyzed](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# The script:
the script performs the preparations and the 5 steps explained in the course as follows:
### 1- data is downloaded from the link and unzipped using `unzip()` function releasing the `UCI HAR Dataset` directory.

### 2- each data file assigned to appropriate variable as follows:
`features` <- features.txt : 561 rows, 2 columns
The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

`activities` <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its labels.

`subject_test` <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed.

`x_test` <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data.

`y_test` <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’ code labels.

`subject_train` <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed.

`x_train` <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data.

`y_train` <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’ code labels.


### 3- Mering data of test together and data of train using `rbind()` function:
`total_x` <- contains combined data of `x_train` and `x_test`
`total_y` <- contains combined data of `y_train` and `y_test`
`total_subject` <- contains combined data of `subject_train` and `subject_test`


### 4- merging all 3 data sets togetherL using `cbind()` function:
`merged_DF` <- contains all merged data of `total_x` , `total_y`, `total_subject`.


### 5- only the measurements of mean and standard deviation were extracting:
by subsetting from the data the `subject`, `label` and the measurements on the `mean` and standard deviation (`std`) for each measurement, creaing `Tdata` (10299 rows, 88 columns).


### 6- Uses descriptive activity names to name the activities in the data set:
by subsetting the column observations to the corresponding activity from the `activity` variable.


### 7- Appropriately labels the data set with descriptive variable names:
code column in `Tdata` renamed into activities
All `Acc` in column’s name replaced by `accelerometer`
All `Gyro` in column’s name replaced by `gyroscope`
All `BodyBody` in column’s name replaced by `body`
All `Mag` in column’s name replaced by `magnitude`
All start with character `f` in column’s name replaced by `frequency`
All start with character `t` in column’s name replaced by `time`


### 8- create an independent tidy data set with the average of each variable for each activity and each subject:
`average_data` (180 rows, 88 columns) is created by grouping with the `subject` and `activity` observations using `group_by()` function then run `mean()` function over all columns using the `summarize_all()` function.


### 9- save the output:
as a text file using the `write.table()` function.
