# The following script, run_analysis.R, takes the UCI HAR Dataset
# Combines the test & train data into a single data set
# Extracts only the measurements on the mean and standard deviation for each measurement
# Labels each activity with a descriptive name rather than number
# Labels the measurements with their descriptive variable names
# Outputs a tidy dataset containing the average for each measurement category across each subject/activity pairing

# check for/load necessary libraries
library(data.table)
library(reshape2)

# read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
# add names
colnames(subject_test) <- ("subject")
colnames(Y_test) <- ("activity")

# read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
# add names
colnames(subject_train) <- ("subject")
colnames(Y_train) <- ("activity")

# read activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
activity_labels <- as.character(activity_labels)

# read features measurements
features <- read.table("UCI HAR Dataset/features.txt")[,2]

# select only measurements on means and standard deviations from the features list
# using regular expressions
selected_features <- grepl("mean\\(|std\\(", features)

# match data with measurement names
names(X_test) <- features
# select only mean/std measurements
X_test <- X_test[, selected_features]

# combine test data by column
test <- cbind(subject_test, Y_test, X_test)

# match data with measurement names
names(X_train) <- features
# select only mean/std measurements
X_train <- X_train[, selected_features]

# combine train data by column
train <- cbind(subject_train, Y_train, X_train)

# combine both datasets by row
combined_data <- rbind(test, train)

# factorize subject & activity; label activities appropriately
combined_data$subject <- as.factor(combined_data$subject)
combined_data$activity <- factor(combined_data$activity, labels = activity_labels)

# final data melting (necessary for using dcast in next step)
melted_data <- melt(combined_data, id=c("subject", "activity"))

# averages each measurement for each subject/activity pair using dcast
final_data <- dcast(melted_data, subject + activity ~ variable, mean)

#output tidy data file
write.table(final_data, "tidy.txt", row.name=FALSE, quote=FALSE)
