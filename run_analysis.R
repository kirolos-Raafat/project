#installing and loading libraries.

install.packages(c("stringr", "tidyverse", "dplyr", "data.table"))
library(tidyverse)
library(dplyr)
library(data.table)
library(stringr)

#downloading the files [to datasets] and reading them.

filurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./project.zip")
#the exdir argument is for setting a path if needed.
unzip("./project.zip", exdir = "./")
#for less typing in the path argument.
setwd("./UCI HAR Dataset")
features <- fread("./features.txt", col.names = c("num", "function"))
activity <- fread("./activity_labels.txt", col.names = c("label", "activity"))
x_test <- fread("./test/X_test.txt", col.names = features$`function`)
y_test <- fread("./test/Y_test.txt", col.names = "label")
subject_test <- fread("./test/subject_test.txt", col.names = "subject")
x_train <- fread("./train/X_train.txt", col.names = features$`function`)
y_train <- fread("./train/Y_train.txt", col.names = "label")
subject_train <- fread("./train/subject_train.txt", col.names = "subject")

#merging the test datas and the train datas.
total_x <- rbind(x_train, x_test)
total_y <- rbind(y_train, y_test)
total_subject <- rbind(subject_train, subject_test)
#merging test and train data together creating 1 dataset.
merged_DF <- cbind(total_subject, total_y, total_x)

#filtering only columns that have mean and std strings in them, for further analysis.
Tdata <- select(merged_DF, subject,label, matches(".*mean.*"), matches(".*std.*"))

#changing the observations with corresponding activity.
Tdata$label <- activity[Tdata$label, 2]

#changing column names to a more descriptive names.
colnames(Tdata)[2] <- "activity"
colnames(Tdata)<-gsub("Acc", "accelerometer", names(Tdata))
colnames(Tdata)<-gsub("Gyro", "gyroscope", names(Tdata))
colnames(Tdata)<-gsub("BodyBody", "body", names(Tdata))
colnames(Tdata)<-gsub("Mag", "magnitude", names(Tdata))
colnames(Tdata)<-gsub("^t", "time", names(Tdata))
colnames(Tdata)<-gsub("^f", "frequency", names(Tdata))
colnames(Tdata)<-gsub("tBody", "timeBody", names(Tdata))


#measuring the mean of each variable depending on activity and subject.
average_data <- Tdata %>% 
    group_by(activity, subject) %>% 
    summarize_all(mean)


#creating a text file of the output for easy and reference access.
setwd("../")
write.table(average_data, "average_data.txt", row.names = F)

