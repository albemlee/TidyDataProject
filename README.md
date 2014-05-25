This repository contains the following files:
=============================================

- 'README.md'

- 'column_names.txt': Contains the names of the columns for 'run_analysis_output.txt'.

- 'run_analysis.R': Contains r-script that performs performs assigned tasks to given dataset.

- 'run_analysis_output.txt': Contains output tidy dataset.

- 'UCI HAR Dataset': Contains given dataset.

'run_analysis.R'
================

- The script performs the following tasks:

	- Merges the training and the test sets to create one data set.

	- Extracts only the measurements on the mean and standard deviation for each measurement. 

	- Uses descriptive activity names to name the activities in the data set

	- Appropriately labels the data set with descriptive activity names. 

	- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- To run the script, open R_studio, source run_analysis.R, and input "run_analysis()".

- The script will output a tidy dataset. You may choose to assign this to a variable.

'run_analysis_output.R'
=======================

- The text file contains the tidy dataset that was output from run_analysis.

- The names of the columns can be found in 'column_names.txt'.

- The row names are in the form, "subject" [subject number] [task].

'UCI HAR Dataset'
=================

- Contains the given dataset and all relevant files.

- Source: 

	[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

	This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

	Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
