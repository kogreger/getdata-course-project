library(reshape2)
setwd("~/Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/getdata-course-project")

# load feature labels (second column in file)
features <- read.table("UCI HAR Dataset/features.txt")[, 2]

# load actual "test" data sets
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
# create descriptive and digestible column names
names(xtest) <- gsub("\\.", "", make.names(features))
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
names(ytest) <- "activity"
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subjecttest) <- "subject"

# load actual "training" data sets
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
# create descriptive and digestible column names
names(xtrain) <- gsub("\\.", "", make.names(features))
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
names(ytrain) <- "activity"
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subjecttrain) <- "subject"

# extract activity labels
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activitylabels) <- c("activity", "actlabel")

# combine single data sets into "test" and "train" data sets
test <- cbind(xtest, ytest, subjecttest)
train <- cbind(xtrain, ytrain, subjecttrain)

# (1) combine "test" and "train" data sets into overall "data" dataset
data <- rbind(test, train)

# (2) reduce data set to subject, activity, and all columns 
#     containing "mean" or "std"
colstokeep <- names(data)[grep("mean|std", names(data))]
data <- data[c("subject", 
               "activity", colstokeep)]

# (3) merge descriptive activity names to overall data set
data <- merge(data, activitylabels)

# (4) apply descriptive variable names and remove unnecessary column
#     that was created when merging the activity labels
names(data)[length(data)] <- "actlabel"
data <- data[, !names(data) %in% c("V1")]

# (5) create second, independent tidy data set with average of each 
#     variable for each activity and each subject
datamelt <- melt(data,
                 id = c("subject", "actlabel"),
                 measure.vars = colstokeep)
tidydata <- dcast(datamelt, subject + actlabel ~ variable, mean)
# export to CSV file
write.table(tidydata, "tidydata.txt", sep=",")