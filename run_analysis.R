# Title     : TODO
# Objective : TODO
# Anna Nezlina

# include library
library(dplyr)

# read information
varnames <- read.table("./UCI HAR Dataset/features.txt")
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
Xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
Ytest <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
Xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
Ytrain <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# merging two sets into one
Subject <- rbind(Subtest, Subtrain)
X <- rbind(Xtest, Xtrain)
Y <- rbind(Ytest, Ytrain)

# mean and standard deviation
selectedvariables <- varnames[grep("mean\\(\\)|std\\(\\)", varnames[, 2]),]

# create colnames
X <- X[, selectedvariables[, 1]]
colnames(X) <- varnames[selectedvariables[, 1], 2]
colnames(Subject) <- "subject"
colnames(Y) <- "activity"
Y$activitylabel <- factor(Y$activity, labels = as.character(actlabels[, 2]))
activity <- Y[, -1]

# result
result <- cbind(Subject, X, activity)
rmean <- result %>% group_by(subject, activity) %>% summarize_each(list(mean))

# create table
write.table(rmean, row.names = FALSE, col.names = TRUE, file = "./result_table.txt")

