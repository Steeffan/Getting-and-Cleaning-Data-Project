##########################
## Settings and options ##
##########################

## Please, set the working directory on the UCI HAR Dataset directory that contains all the data
setwd("~/Coursera/Getting and Cleaning/Project/UCI HAR Dataset")

## Export dataset
## if TRUE export the averageData into the export File

exportData <- TRUE
exportFile <- "averageData.txt"

#####################################################################
## 1.Merges the training and the test sets to create one data set. ##
#####################################################################

## Loads test data
X_test <- read.table("./test/X_test.txt", comment.char = "")
y_test <- read.table("./test/y_test.txt", col.names = "activityid", colClasses="factor", comment.char = "")
subject_test <- read.table("./test/subject_test.txt", col.names = "subject", colClasses="factor", comment.char = "")

## Loads train data
X_train <- read.table("./train/X_train.txt", comment.char = "")
y_train <- read.table("./train/y_train.txt", col.names = "activityid", colClasses="factor", comment.char = "")
subject_train <- read.table("./train/subject_train.txt", col.names = "subject", colClasses="factor", comment.char = "")

## Merges all the training and tests data in one dataset
dataSet <- cbind(
                  rbind(y_test, y_train)
                 ,rbind(subject_test, subject_train)
                 ,rbind(X_test, X_train)
                )

###############################################################################################
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. ##
###############################################################################################

## Load features
features <- read.table("features.txt", col.names = c("featureid","feature"), stringsAsFactors=FALSE)

## Extract names with mean, meanFreq ans std in them
featuresFilter <- features[grep("-(mean|meanFreq|std)\\(\\)", features$feature),]

## Subset columns of the dataSet to keep only mean ans standard deviation measures
dataSet <- dataSet[,c(1,2,featuresFilter[,1]+2)] ## Add +2 because two first columns are activityID and subjectID

################################################################################
## 3. Uses descriptive activity names to name the activities in the data set. ##
################################################################################

## Load activities
activities <- read.table("activity_labels.txt", col.names = c("activityid","activity"), colClasses=c("factor","factor"))

## Merge dataSet and activities to ger activity label
dataSet <- merge(activities,dataSet,by="activityid")

## Check if there ara any NA values in the data set
if (sum(sapply(dataSet, function(x) sum(is.na(x))))==0) {
        message("No NA values in the data set")
} else {
        message("There are NA values in the data set, you should clean it")
}

###########################################################################
## 4. Appropriately labels the data set with descriptive variable names. ##
###########################################################################

## lower all letters in the left name part (before symbol "-") and no change in the right name part (after symbol "-")
featuresFilter$featureClean <- tolower(featuresFilter$feature)

## Define the replacement rule names (eg : bodybody -> body, -mean() -> Mean, etc...)
ruleNames <- data.frame(
         searchString=c("bodybody","-mean\\(\\)$","-meanfreq\\(\\)$","-std\\(\\)$"
        ,"-mean\\(\\)-","-meanfreq\\(\\)-","-std\\(\\)-","x$","y$","z$")
        ,replaceString=c("body","Mean","Meanfreq","Std","Mean","Meanfreq","Std","X","Y","Z")
)

## Apply the replacement rule names
for (i in 1:nrow(ruleNames)) {
        searchString <- as.character(ruleNames$searchString[[i]])
        replaceString <- as.character(ruleNames$replaceString[[i]])
        
        featuresFilter$featureClean <- sub(searchString, replaceString, featuresFilter$featureClean)
}

## Control that all column names are unique else throw an error
if (length(featuresFilter$featureClean)==length(unique(featuresFilter$featureClean))) {
        message("Column Names are unique.")
} else {
        stop("Column names are not unique!!!")
}

## Label the dataset with descriptive names
names(dataSet)[-c(1,2,3)] <- featuresFilter$featureClean  ## 3 first columns are not features

###################################################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable ##
##    for each activity and each subject.                                                                        ##
###################################################################################################################

averageData <- aggregate(dataSet[,-c(1,2,3)],list(activity=dataSet$activity,subject=dataSet$subject),mean,na.rm=TRUE)        

####################################################################
## Output, export the dataframe averageData in the exportFile     ##
####################################################################

if (exportData) {
        write.table(averageData,exportFile,row.names=FALSE)        
}


