# Getting and Cleaning Data Project

Intoduction
===========

The repository contains all the required elements for the coursera Getting and Cleaning Data Project :

* the present readme file that describes the project
* the source script run_analysis.R for reproducibility
* the code book with the data description


### About the original project

This project is based on the original project "Human Activity Recognition Using Smartphones Data Set".
Raw data files and their description can be found at [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


### The tidy data set

The tidy data set is loaded in the coursera project form as required.
However, the script run_analysis.R provided allows to reproduce it.


Instruction list
===========

To reproduce the tidy data process, follow the steps :

1. Uncompress all the files and directories from the the original archive file "getdata_projectfiles_UCI HAR Dataset.zip" described in the About the original project section.
  To run properly the code, you should not make any kind of modifications on these files.
1. Open the run_analysis.R script in R Studio.
1. Set the working directory to the root directory "UCI HAR Dataset" of the uncompressed data in step 1
1. Set the exportData variable to TRUE/FALSE depending if you want to export data output or not and set the name of this ouptput file in the variable exportFile.
  Keep default values is fine.
* Run the script.

This script has been developped on a Windows 7 Professional 64 bits machine, with RStudio (version 0.98.1091 and R version 3.1.2).


Script run_analysis.R
===========

This is a description of the code run by the script run_analysis.R.


#### Settings and options

See Instruction list above.


#### 1. Merges the training and the test sets to create one data set.

Training data (resp. test data) are each split in 3 files : a file with the measures vectors, a file with the activity that corresponds to the observation and a file with the subject that
corresponds to the observation.
The only way to merge together the training data (resp. test data) is to rely on the position of the row in the files as there are no identifier columns in the measures vectors files.

The 3 raw data files are merged by "pasting" the data side by side with the cbind() function. This operation is done for the training data and the test data to obtain one training data set
and one test data set.

Then the traininig data set and the test data set are merged with the rbind() function to obtain one data set.

The final data set is strored in the data frame `dataSet`.


#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

In the original variables description, 3 measures are candidate :

* mean(): Mean value
* std(): Standard deviation
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency

The 2 first measures are quite obvious. The third one could be discussed but I decided to include it in the data set as the result of the meanFreq() is
a mean value.

To select this columns, the file features.txt that contains the features is loaded in the data frame features.
Then, the grep function is used to extract the column names with the patterns -mean(), -meanFreq() and -std() ("-(mean|meanFreq|std)\\(\\)")
and stored in the data frame featuresFilter. 79 measures over the 561 original are extracted (see the code book for more information).

Finally, the dataSet columns are subsetted on these 79 candidates.

  
#### 3. Uses descriptive activity names to name the activities in the data set

The file activity_labels.txt that contains the activity labels is loaded in the data frame activities and it is merged with the data set.

At this step, a control is made to check NA values and no NA values were found.


#### 4. Appropriately labels the data set with descriptive variable names. 

As the original 79 variable names violate various naming rules, this step consists in renaming them properly by :

* lowering all the letters
* replacing strings (bodybody -> body, -mean() -> Mean, etc...). I reintroduce capital letters here for the functions Mean, Std and Meanfreq and
  for the axis X, Y and Z for readability
* check if column names are unique

The list of the search strings and their respective replace strings is written into the data frame ruleNames and the rename process makes a loop
through the data frame content.

The new variable names are stored in the column featureClean of the data frame featuresFilter (see the code book for mor information).

A control is made to check the unicity of the variable names and it is respected.

Finally, the column names of the data set are changed to these labels.


#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For this step, I preferred the wide form with 180 observations (6 activities x 30 subjects) and 81 variables (activity, subject and 79 measures) (see the code book for mor information).
I believe that it meets the tidy data principles (Each variable you measure should be in one column, Each different observation of that variable should be in a different row)
and it is quite compact.

This data set is stored in the data frame `averageData`.


#### Export the tidy data set created in the step 5

If the variable exportData is set to TRUE, the data set averageData is exported to the exportFile file (see Settings and options).

