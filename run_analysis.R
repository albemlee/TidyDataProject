setwd("~/Desktop/Education/Coursera/DataScience/03GettingCleaningData/TidyDataProject")
library(purrr)
library(dplyr)

# Load data
feature_set <- read.table('UCI HAR Dataset/features.txt')
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')

train_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
train_X <- read.table('UCI HAR Dataset/train/X_train.txt')
train_Y <- read.table('UCI HAR Dataset/train/y_train.txt')
names(train_subjects) <- "subjectID"
names(train_X) <- feature_set$V2
names(train_Y) <- "activityLabel"
train_set <- cbind(train_X, train_subjects, train_Y)

test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
test_X <- read.table('UCI HAR Dataset/test/X_test.txt')
test_Y <- read.table('UCI HAR Dataset/test/y_test.txt')
names(test_subjects) <- "subjectID"
names(test_X) <- feature_set$V2
names(test_Y) <- "activityLabel"
test_set <- cbind(test_X, test_subjects, test_Y)

# Merge train_set and test_set
data <- rbind(train_set, test_set)

# Extract measurements on the mean and standard deviation for each measurement.
data <- data[, grepl('std[()-]',feature_set$V2) | grepl('mean[()-]',feature_set$V2)]

# Use descriptive activity names to name the activities in the data set
for(i in 1:6){
  data[data$activityLabel == i, 'activityLabel'] <- as.character(activity_labels[activity_labels$V1 == i, 'V2'])
}

# Create an independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- data %>%
  group_by(activityLabel, subjectID) %>%
  summarize_all(mean)
  
write.table(tidy_data, 'tidy_data.txt', row.names = FALSE)
