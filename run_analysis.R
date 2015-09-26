# read in activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# read in features measurements
features <- read.table("UCI HAR Dataset/features.txt")[,2]

# select only measurements on means and standard deviations from the features list
selected_features <- grepl("mean|std", features)

# read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# match data with measurement names
names(X_test) <- features
# select only mean/std measurements
X_test <- X_test[, selected_features]

# read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

# match data with measurement names
names(X_train) <- features
# select only mean/std measurements
X_train <- X_train[, selected_features]



