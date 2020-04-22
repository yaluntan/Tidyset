setwd("~/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
x_test <- read.table("test/X_test.txt",header=FALSE)
x_train <- read.table("train/X_train.txt",header=FALSE)

y_test <- read.table("test/y_test.txt",header=FALSE)
subject_test <- read.table("test/subject_test.txt",header=FALSE)

y_train <- read.table("train/y_train.txt",header=FALSE) 
subject_train <- read.table("train/subject_train.txt",header=FALSE)

features <- read.table("features.txt",header=FALSE)
activity_labels <- read.table("activity_labels.txt",header=FALSE)

colnames(x_train) = features[,2]
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"

colnames(x_test) = features[,2]
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"
# View(activity_labels)
colnames(activity_labels) = c("activityId","activityType")

merge_train = cbind(y_train, subject_train, x_train)
merge_test = cbind(y_test, subject_test, x_test)

combined = rbind(merge_train, merge_test)

colNames = colnames(combined)

mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#A subtset has to be created to get the required dataset
setForMeanAndStd <- combined[ , mean_and_std == TRUE]
setWithActivityNames = merge(setForMeanAndStd, activity_labels, by='activityId', all.x=TRUE)

TidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
TidySet <- TidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(TidySet, "TidySet.txt", row.name=FALSE)

