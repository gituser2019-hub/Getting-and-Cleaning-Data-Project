## Download data from designated website
setwd("~/Data Science/Files/3/project")

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists('./getdata_projectfiles_UCI HAR Dataset.zip')){
        download.file(url,destfile<-'getdata_projectfiles_UCI HAR Dataset.zip', mode = 'wb')
        unzip('getdata_projectfiles_UCI HAR Dataset.zip', exdir = getwd())}




## Read All Data Files
setwd("~/Data Science/Files/3/project/UCI HAR Dataset")

features <- read.table('features.txt')

activity_labels<-read.table('activity_labels.txt')

train_x <- read.table('./train/X_train.txt')
train_y <- read.table('./train/y_train.txt')
train_subject <- read.table('./train/subject_train.txt')

test_x <- read.table('./test/X_test.txt')
test_y <- read.table('./test/y_test.txt')
test_subject <- read.table('./test/subject_test.txt')




## Merge Train and Test Data Into One Data Set
train<-data.frame(train_x,train_y,train_subject) 
test<-data.frame(test_x,test_y,test_subject)
data<-rbind(train,test)




## Extracts only the measurements on the mean and standard deviation for each measurement.
names(data)<-c(as.character(features[,2]))
names(data)[562]<-'labels'
names(data)[563]<-'subject'
extract <- grep('mean\\(\\)|std\\(\\)', features[,2])
extract_data <- data[,c(562,563,extract)]




## Uses descriptive activity names to name the activities in the data set
extract_data[, 69] <- activity_labels[extract_data[, 1], 2]
names(extract_data)[69]<-'activity'
extract_data<-extract_data[,c(1,69,2,3:68)]




## Appropriately labels the data set with descriptive variable names
names(extract_data)<-gsub("Acc", "Accelerometer", names(extract_data))
names(extract_data)<-gsub("Gyro", "Gyroscope", names(extract_data))
names(extract_data)<-gsub("BodyBody", "Body", names(extract_data))
names(extract_data)<-gsub("Mag", "Magnitude", names(extract_data))
names(extract_data)<-gsub("^t", "TimeDomain_", names(extract_data))
names(extract_data)<-gsub("^f", "FrequencyDomain_", names(extract_data))
names(extract_data)<-gsub("-mean()", "_Mean", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-std()", "_StandardDeviation", names(extract_data), ignore.case = TRUE)




## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-aggregate(extract_data[4:69], by=list(activity = extract_data$activity, subject=extract_data$subject), mean)




## Write the tidy data into a file
setwd("~/Data Science/Files/3/project")
write.table(tidy_data, "Tidy Data.txt", row.name=FALSE)
