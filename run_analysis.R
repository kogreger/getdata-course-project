library(reshape2)

# load data
setwd("Documents/Coursera/Data Science Specialization/Getting and Cleaning Data/getdata/")

# extract feature labels (second column in file)
features <- read.table("UCI HAR Dataset/features.txt")[, 2]

# load actual "test" data sets
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(x.test) <- features
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
names(y.test) <- "activity"
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject.test) <- "subject"

# load actual "training" data sets
x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(x.train) <- features
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
names(y.train) <- "activity"
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subject.train) <- "subject"

# extract activity labels
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity.labels) <- c("activity", "act.label")

# check for equal object sizes
nrow(x.test) == nrow(y.test) & nrow(y.test) == nrow(subject.test)
nrow(x.train) == nrow(y.train) & nrow(y.train) == nrow(subject.train)

# combine single data sets into "test" and "train" data sets
test <- cbind(x.test, y.test, subject.test)
train <- cbind(x.train, y.train, subject.train)

# combine "test" and "train" data sets into overall "data" dataset
data <- rbind(test, train)

# reduce data set to subject, activity, and all columns 
# containing "mean" or "std"
cols.to.keep <- names(data)[grep("mean|std", names(data))]
data <- data[c("subject", 
               "activity", cols.to.keep)]

# merge descriptive activity names to overall data set
data <- merge(data, activity.labels, by.x = "activity", by.y = "activity")



# create second, independent tidy data set with average of each 
# variable for each activity and each subject
data_melt <- melt(data, 
                  id = c("subject", "act.label"), 
                  measure.vars = cols.to.keep)
tidy.data <- dcast(data_melt, subject + act.label ~ variable, mean)