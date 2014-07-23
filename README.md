getdata-course-project
======================

Repository for the course project of Coursera Class "Getting and Cleaning Data" by Johns Hopkins Bloomberg School of Public Health (cf. https://class.coursera.org/getdata-004/)

## Data Processing

The main R code for loading, processing and tidily exporting the Samsung Galaxy S accelerometer data lives in file run_analysis.R. While the code is neatly commented, these are the steps of the data processing pipeline:

1. loading required "reshape2" library and setting working directory
2. loading feature names from file "features.txt" - the feature labels themselves live in the second column
3. loading the test data from file "X_test.txt"
4. removing possibly problematic characters from column names and making them more readble in the process by removing all "."s using gsub
5. loading activity information for test data from file "y_test.txt", and providing the data a more descriptive column name
6. loading subject information for test data from file "subject_test.txt", and providing the data a more descriptive column name
7. repeating steps 2-6 for the training data 
8. loading activity labels from file "activity_labels.txt" and providing the data more descriptive column names
9. combining the accelerometer data, activity data and subject data for the test data set using cbind
10. repeating step 9 for the training data
11. combining the test and training data sets using rbind -> **course project requirement 1**
12. removing all unnecessary columns from the new data set, i.e. all that don't contain information about subject, activity, or and mean or standard deviation data using grep - this might leave unnecessary columns in the dataset, yet the course project description did not provide the details necessary to identify the required columns -> **course project requirement 2**
13. merging the activity labels from the activity label data to the new data set -> **course project requirement 3**
14. removing an unnecessary coulmn from the new, merged data set, that was generated by the merge in step 13 and renaming the column containing the activity label more descriptively -> **course project requirement 4**
15. creating second, independent tidy data set with average of each variable for each activity and each subject using melt and dcast -> **course project requirement 5**
16. exporting the new tidy data set to a CSV file "tidydata.txt" in the working directory

## Data Description

Detailed information about the data structure can be found in the codebook.