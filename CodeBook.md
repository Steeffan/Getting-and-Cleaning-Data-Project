# Code book

This code book gives an outlook of the experimental design, the raw data, the description of the tidy process and the 2 tidy data sets.

This project is based on the original project "Human Activity Recognition Using Smartphones Data Set".
Project description, raw data files and their description can be found at [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


Experimental design and background
====================

Original description of the experiments can be found in the README.txt file in the archive file.

This is an extract of the original description :

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity.
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Raw data
========

Original description of the raw data can be found in the features_info.txt file in the archive file.

The raw data are splitted in 6 data files :

* X_train and X_test files : contain all the observations (7.352 for the training sample and 2.947 for the test sample) of the 561-feature vector for the training and test samples
* y_train and y_test files : contain the activity identifier for every observation (7.352 for the training sample and 2.947 for the test sample)
* subject_train and subject_test files : contain the subject identifier for every observation (7.352 for the training sample and 2.947 for the test sample)

There are 2 files for the labels :

* features.txt file : contains the list of the features
* activity_labels.txt file : links the activity identifier with his activity name

Notes : 

* Features are normalized and bounded within -1 and 1
* Each feature vector is a row on the text file


Processed data
=========

First, the 3 raw data files for each training and test samples are merged by "pasting" the data side by side with the cbind() function to obtain one training data set and one test data set.
Then these 2 data set are merged together with the rbind() function to obtain one data set containing all training and test data.

From this data set, we extract the measurements on the mean and standard deviation for each measurement from the features.txt file.
According to the description of the variables, 3 type of variables have been selected :

* mean(): Mean value
* std(): Standard deviation
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency

Based on these criteria, we extract 79 measurements from the 561 original.

Then, the activity label is inserted in the data set by joining the activityid from the data set with the activityid in the file activity_labels.txt.

Finally, the 79 measurements in the data set are named from their feature names doing some cleaning operation like :
* lower all the capital letters in the feature part of the name (eg: tBodyAcc -> tbodyacc)
* quit forbidden characters like "-", "(" and ")", or replicated information (eg: bodybody -> body)

The correspondance between the original measurements names and the labels in the data set is shown in the List of labels for each measurements section below.

We obtain the first tidy data set named `dataSet`

The second tidy data set, `averageData`, is derived from dataSet by calculating the mean of each of the 79 measurements grouping by activity and subject.


Tidy data sets
==========

`dataSet`
This data set is a data frame with 10.299 observations and 82 variables.
The 10.299 observations represent the total of observations from the training and test samples realized in the experiments.
There are no NA values in all the data set.

The 82 variables are :

* activityid	: the activity identifier, 6 levels factor in the range [1, 6]
* activity	: the activity name, 6 levels factor in ("LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS")
* subject	: the subject identifier, 30 levels factor from [1, 30]
* 79 variables	: 79 mean and standard deviation measures, numerical, normalized (no units) and bounded within -1 and 1 (see their description in the Features description section)


`averageData`
This data set is a data frame with 180 observations and 81 variables.
There is one row for each combinaison of subject and activity (30 subjects x 6 activities = 180).
There are no NA values in all the data set.

The 81 variables are :

* activity	: the activity name, 6 levels factor in ("LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS")
* subject	: the subject identifier, 30 levels factor from [1, 30]
* 79 variables	: mean of the 79 mean and standard deviation measures, numerical, normalized and bounded within -1 and 1 (see their description in the Features description section)
		  the list of the 79 variables is the same as for dataSet (see above)


Features description
================

This section comes form the original features_info.txt and has been adapated to the new labels of the features and the measurements.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz.
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tbodyacc-XYZ and tgravityacc-XYZ) using
another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tbodyaccjerk-XYZ and tbodygyrojerk-XYZ).
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tbodyaccmag, tgravityaccmag, tbodyaccjerkmag, tbodygyromag, tbodygyrojerkmag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fbodyacc-XYZ, fbodyaccjerk-XYZ, fbodygyro-XYZ, fbodyaccjerkmag, fbodygyromag, bodygyrojerkmag.
(Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:   '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tbodyacc-XYZ
tgravityacc-XYZ
tbodyaccjerk-XYZ
tbodygyro-XYZ
tbodygyrojerk-XYZ
tbodyaccmag
tgravityaccmag
tbodyaccjerkmag
tbodygyromag
tbodygyrojerkmag

fbodyacc-XYZ
fbodyaccjerk-XYZ
fbodygyro-XYZ
fbodyaccmag
fbodyaccjerkmag
fbodygyromag
fbodygyrojerkmag

The set of variables that were estimated from these signals are: 

Mean(): Mean value
Std(): Standard deviation
Meanfreq(): Weighted average of the frequency components to obtain a mean frequency


List of labels for each measurements
======================

Here is the list of new labels for the original features

1. tBodyAcc-mean()-X -> tbodyaccMeanX
1. tBodyAcc-mean()-Y -> tbodyaccMeanY
1. tBodyAcc-mean()-Z -> tbodyaccMeanZ
1. tBodyAcc-std()-X -> tbodyaccStdX
1. tBodyAcc-std()-Y -> tbodyaccStdY
1. tBodyAcc-std()-Z -> tbodyaccStdZ
1. tGravityAcc-mean()-X -> tgravityaccMeanX
1. tGravityAcc-mean()-Y -> tgravityaccMeanY
1. tGravityAcc-mean()-Z -> tgravityaccMeanZ
1. tGravityAcc-std()-X -> tgravityaccStdX
1. tGravityAcc-std()-Y -> tgravityaccStdY
1. tGravityAcc-std()-Z -> tgravityaccStdZ
1. tBodyAccJerk-mean()-X -> tbodyaccjerkMeanX
1. tBodyAccJerk-mean()-Y -> tbodyaccjerkMeanY
1. tBodyAccJerk-mean()-Z -> tbodyaccjerkMeanZ
1. tBodyAccJerk-std()-X -> tbodyaccjerkStdX
1. tBodyAccJerk-std()-Y -> tbodyaccjerkStdY
1. tBodyAccJerk-std()-Z -> tbodyaccjerkStdZ
1. tBodyGyro-mean()-X -> tbodygyroMeanX
1. tBodyGyro-mean()-Y -> tbodygyroMeanY
1. tBodyGyro-mean()-Z -> tbodygyroMeanZ
1. tBodyGyro-std()-X -> tbodygyroStdX
1. tBodyGyro-std()-Y -> tbodygyroStdY
1. tBodyGyro-std()-Z -> tbodygyroStdZ
1. tBodyGyroJerk-mean()-X -> tbodygyrojerkMeanX
1. tBodyGyroJerk-mean()-Y -> tbodygyrojerkMeanY
1. tBodyGyroJerk-mean()-Z -> tbodygyrojerkMeanZ
1. tBodyGyroJerk-std()-X -> tbodygyrojerkStdX
1. tBodyGyroJerk-std()-Y -> tbodygyrojerkStdY
1. tBodyGyroJerk-std()-Z -> tbodygyrojerkStdZ
1. tBodyAccMag-mean() -> tbodyaccmagMean
1. tBodyAccMag-std() -> tbodyaccmagStd
1. tGravityAccMag-mean() -> tgravityaccmagMean
1. tGravityAccMag-std() -> tgravityaccmagStd
1. tBodyAccJerkMag-mean() -> tbodyaccjerkmagMean
1. tBodyAccJerkMag-std() -> tbodyaccjerkmagStd
1. tBodyGyroMag-mean() -> tbodygyromagMean
1. tBodyGyroMag-std() -> tbodygyromagStd
1. tBodyGyroJerkMag-mean() -> tbodygyrojerkmagMean
1. tBodyGyroJerkMag-std() -> tbodygyrojerkmagStd
1. fBodyAcc-mean()-X -> fbodyaccMeanX
1. fBodyAcc-mean()-Y -> fbodyaccMeanY
1. fBodyAcc-mean()-Z -> fbodyaccMeanZ
1. fBodyAcc-std()-X -> fbodyaccStdX
1. fBodyAcc-std()-Y -> fbodyaccStdY
1. fBodyAcc-std()-Z -> fbodyaccStdZ
1. fBodyAcc-meanFreq()-X -> fbodyaccMeanfreqX
1. fBodyAcc-meanFreq()-Y -> fbodyaccMeanfreqY
1. fBodyAcc-meanFreq()-Z -> fbodyaccMeanfreqZ
1. fBodyAccJerk-mean()-X -> fbodyaccjerkMeanX
1. fBodyAccJerk-mean()-Y -> fbodyaccjerkMeanY
1. fBodyAccJerk-mean()-Z -> fbodyaccjerkMeanZ
1. fBodyAccJerk-std()-X -> fbodyaccjerkStdX
1. fBodyAccJerk-std()-Y -> fbodyaccjerkStdY
1. fBodyAccJerk-std()-Z -> fbodyaccjerkStdZ
1. fBodyAccJerk-meanFreq()-X -> fbodyaccjerkMeanfreqX
1. fBodyAccJerk-meanFreq()-Y -> fbodyaccjerkMeanfreqY
1. fBodyAccJerk-meanFreq()-Z -> fbodyaccjerkMeanfreqZ
1. fBodyGyro-mean()-X -> fbodygyroMeanX
1. fBodyGyro-mean()-Y -> fbodygyroMeanY
1. fBodyGyro-mean()-Z -> fbodygyroMeanZ
1. fBodyGyro-std()-X -> fbodygyroStdX
1. fBodyGyro-std()-Y -> fbodygyroStdY
1. fBodyGyro-std()-Z -> fbodygyroStdZ
1. fBodyGyro-meanFreq()-X -> fbodygyroMeanfreqX
1. fBodyGyro-meanFreq()-Y -> fbodygyroMeanfreqY
1. fBodyGyro-meanFreq()-Z -> fbodygyroMeanfreqZ
1. fBodyAccMag-mean() -> fbodyaccmagMean
1. fBodyAccMag-std() -> fbodyaccmagStd
1. fBodyAccMag-meanFreq() -> fbodyaccmagMeanfreq
1. fBodyBodyAccJerkMag-mean() -> fbodyaccjerkmagMean
1. fBodyBodyAccJerkMag-std() -> fbodyaccjerkmagStd
1. fBodyBodyAccJerkMag-meanFreq() -> fbodyaccjerkmagMeanfreq
1. fBodyBodyGyroMag-mean() -> fbodygyromagMean
1. fBodyBodyGyroMag-std() -> fbodygyromagStd
1. fBodyBodyGyroMag-meanFreq() -> fbodygyromagMeanfreq
1. fBodyBodyGyroJerkMag-mean() -> fbodygyrojerkmagMean
1. fBodyBodyGyroJerkMag-std() -> fbodygyrojerkmagStd
1. fBodyBodyGyroJerkMag-meanFreq() -> fbodygyrojerkmagMeanfreq
