run_analysis <- function(){

##Merges the training and the test sets to create one data set.
read.table("UCI HAR Dataset/test/X_test.txt") -> X_test
read.table("UCI HAR Dataset/train/X_train.txt") -> X_train
X <- rbind(X_test, X_train)

##Extracts only the measurements on the mean and standard deviation
##for each measurement.
columnnames <- read.table("UCI HAR Dataset/features.txt")
containmean <- vector(mode = "logical", length = max(columnnames[,1]))
for(i in 1:max(columnnames[,1])){
  containmean[i] <- grepl("mean()",columnnames[i,2])
}
containstd <- vector(mode = "logical", length = max(columnnames[,1]))
for(i in 1:max(columnnames[,1])){
  containstd[i] <- grepl("std()",columnnames[i,2])
}
stdormean <- xor(containmean,containstd)
stdormean <- t(stdormean)
columnnamestransposed <- t(columnnames)
relevantcolumns <- rbind(columnnamestransposed[1,][stdormean],
                         columnnamestransposed[2,][stdormean])
data <- X[,as.numeric(relevantcolumns[1,])]
##Uses descriptive activity names to name the activities in the data
##set.
read.table("UCI HAR Dataset/test/subject_test.txt") -> subject_test
read.table("UCI HAR Dataset/train/subject_train.txt") -> subject_train
subject <- rbind(subject_test,subject_train)
read.table("UCI HAR Dataset/test/Y_test.txt") -> Y_test
read.table("UCI HAR Dataset/train/Y_train.txt") -> Y_train
Y <- rbind(Y_test,Y_train)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
Y[Y == 1] <- as.character(activity_labels[,2][activity_labels[,1] == 1])
Y[Y == 2] <- as.character(activity_labels[,2][activity_labels[,1] == 2])
Y[Y == 3] <- as.character(activity_labels[,2][activity_labels[,1] == 3])
Y[Y == 4] <- as.character(activity_labels[,2][activity_labels[,1] == 4])
Y[Y == 5] <- as.character(activity_labels[,2][activity_labels[,1] == 5])
Y[Y == 6] <- as.character(activity_labels[,2][activity_labels[,1] == 6])

##Appropriately labels the data set with descriptive activity names. 
rownames <- cbind(1:nrow(Y),vector(mode = "character",length = nrow(Y)))
for(i in 1:nrow(rownames)){
  rownames[i,2] <- paste("subject",subject[i,],Y[i,],sep="")
}
for(i in 1:nrow(rownames)){
  row.names(data)[i] <- paste(rownames[i,2],i,sep="")
}

##Creates a second, independent tidy data set with the average of each
##variable for each activity and each subject.
data2 <- data.frame(row.names = unique(rownames[,2]))
data2 <- cbind(data2,matrix(nrow = length(unique(rownames[,2])),
                            ncol = ncol(data)))
rowminmax <- data.frame(row.names = unique(rownames[,2]))
rowminmax <- cbind(rowminmax,matrix(nrow = length(unique(rownames[,2])),
                                ncol = 2))
for(i in 1: nrow(rowminmax)){
  rowminmax[i,1] <- min(rownames[rownames[,2]==row.names(rowminmax)[i],1])
  rowminmax[i,2] <- max(rownames[rownames[,2]==row.names(rowminmax)[i],1])
}
for(j in 1:nrow(data2)){
  for(i in 1:ncol(data2)){
    data2[j,i] <- mean(data[rowminmax[j,1]:rowminmax[j,2],i])
  }
}

return(data2)

}