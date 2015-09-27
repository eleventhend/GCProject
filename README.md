# UCI HAR Data analysis
## run_analysis.R

###run_analysis.R takes the UCI HAR Dataset as an input, which must be present in the working directory.

###run_analysis.R does the following:

1. Combines the test & train data into a single data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Labels each activity with a descriptive name rather than number
4. Labels the measurements with their descriptive variable names
5. Outputs a tidy dataset containing the average for each measurement category across each subject/activity pairing
