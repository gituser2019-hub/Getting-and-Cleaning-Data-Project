## Overall Description
The Cleaning Data.R script loads data and then cleans up the data using the 5 steps as described in the course project’s instructions.



## Download data from designated website
If the data doesn't exist in the current working directory, download the Dataset as zip files and unzipped under the folder called UCI HAR Dataset



## Read All Data Files
features <- features.txt : 561 records, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

activities_labels <- activity_labels.txt : 6 records, 2 columns  
has activity class labels and activity name information.

train_x <- test/X_train.txt : 7352 records, 561 columns  
contains recorded features train data

train_y <- test/y_train.txt : 7352 records, 1 column  
contains train data of activities class labels

train_subject <- test/subject_train.txt : 7352 records, 1 column  
contains train data of 70% of volunteer subjects being observed

test_x <- test/X_test.txt : 2947 records, 561 columns  
contains recorded features test data

test_y <- test/y_test.txt : 2947 records, 1 columns  
contains test data of activities class labels

test_subject <- test/subject_test.txt : 2947 records, 1 column  
contains test data of 30% of volunteer test subjects being observed




## Merge Train and Test Data Into One Data Set
train (7352 records, 563 columns) is created by joining the x, y and subject within the train data set into the new train data frame  

test (2947 records, 563 column) is created by joining the x, y and subject within the test data set into the new test data frame 

data (10299 records, 563 column) is created by merging train and test data set using the rbind() function  




## Extracts only the measurements on the mean and standard deviation for each measurement.
extract_data (10299 records, 69 columns) is created by subsetting data, selecting only columns on the mean and standard deviation for each measurement  




## Uses descriptive activity names to name the activities in the data set
Vector column names (V1, V2 etc..) of the extract_data replaced with corresponding activity taken from second column of the activities variable where applicable. This is like looking up activity description value using the "labels" column in data  




## Appropriately labels the data set with descriptive variable names
Replace the abbreviated part of column names in extract_data by the longer version descriptions, transformation rule as follows: 

All "Acc" in column’s name replaced by "Accelerometer"  
All "Gyro" in column’s name replaced by "Gyroscope"  
All "BodyBody" in column’s name replaced by "Body"  
All "Mag" in column’s name replaced by "Magnitude"  
All start with character t in column’s name replaced by "TimeDonmain_"  
All start with character f in column’s name replaced by "FrequencyDomain_"  
All "-mean()" in column's name replaced by "_Mean" (regardless of the letter cases in "-mean()"  
All "-std()" in column's name replaced by "_StandardDeviation" (regardless of the letter cases in "-std()"  



## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data (180 rows, 68 columns) is created by sumarizing extract_data taking the means of each variable for each activity and each subject, after aggregating by subject and activity.  

Write the tidy_data into a file called Tidy Data.txt  
