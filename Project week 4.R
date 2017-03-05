##0. Downloading and unzipping dataset

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./Dataset.zip",exdir="./data")


#1. Merges the training and the test sets to create one data set:
       #1a. Reading all source files

# Reading trainings tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')


        #1.b Assigning column names:
        
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

         #1.c Merging all data in one set:
        
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
Test_Train_combined <- rbind(merge_train, merge_test)


#4. Extracting only the measurements on the mean and standard deviation for each measurement
        #4.a Reading column names to be used for lookup :
        
        colNames <- colnames(Test_Train_combined) 
 
#  4.b Create vector for defining ID, mean and standard deviation:
        
        mean_and_std <- 
        (grepl("activityId" , colNames) | 
         grepl("subjectId" , colNames) | 
         grepl("mean" , colNames) | 
         grepl("std" , colNames) 
        )
#4.c select only the measurements on mean and standard deviation 
        
        Set_on_mean_sd <- Test_Train_combined[ , mean_and_std == TRUE]
        
        View(Set_on_mean_sd)
        
       # Uses descritive names and appropriately labels        
        Set_on_mean_sd_labelled <- 
                merge(Set_on_mean_sd, activityLabels,
        by.x = c('activityId') ,by.y = c('activityId') )
        
      #  View(Set_on_mean_sd_labelled)
        
     
#5. cREATE dataset based on average in  4.c dataset
        
        set_on_average <- aggregate(. ~subjectId + activityId, Set_on_mean_sd_labelled, mean)      
           
        set_on_average_ordered <-  set_on_average[order( set_on_average$subjectId,  set_on_average$activityId),]

  ##Write table to txt file      
write.table( set_on_average_ordered, file = "set_on_average_ordered.txt", row.names = FALSE)
        
        