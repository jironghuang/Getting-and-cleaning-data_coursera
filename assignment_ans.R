# You should create one R script called run_analysis.R that does the following.
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

############################################
library(plyr)

#Set your own directory which contains the unzipped dataset in order to replicate the results 
setwd("C:/Users/Huang Jirong/Desktop/Getting and Cleaning Data/Week 4/UCI HAR Dataset")


#load in x data
xtrain = read.table("train/X_train.txt")
xtest = read.table("test/X_test.txt")
x_dat = rbind(xtrain,xtest)
rm(xtrain,xtest)

#load in y data
ytrain = read.table("train/y_train.txt")
ytest = read.table("test/y_test.txt")
y_dat = rbind(ytrain,ytest); names(y_dat) = "activity"
rm(ytrain,ytest)

#Load in person (subject) id
subjectTrain = read.table("train/subject_train.txt")
subjectTest = read.table("test/subject_test.txt")
subject = rbind(subjectTrain,subjectTest); names(subject) = "subject_num"
rm(subjectTrain,subjectTest)

############################################
#load in features. nrow = 561 which corresponds to number of rows in xtest and xtrain
# Extracts only the measurements on the mean and standard deviation for each measurement.
features = read.table("features.txt"); names(features) = c("feature_num","feature_descr")
features$cont_mean_sd = ifelse((grepl("mean|std",features$feature_descr)),1,0)
names_w_mean_sd = subset(features,features$cont_mean == 1)


############################################
# Uses descriptive activity names to name the activities in the data set
x_mean_sd = x_dat[,as.numeric(names_w_mean_sd$feature_num)]
colnames(x_mean_sd) = names_w_mean_sd$feature_descr

############################################
# Merges the training and the test sets to create one data set.
agg_dat = cbind(subject,y_dat,x_mean_sd)

############################################
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
avg_subj_act = ddply(agg_dat, .avg_subj_act(subject_num, activity), function(x) colMeans(x[, 2:81]))

#Function to return the dataset
ret_dat = function(data,dirname){

  write.csv(data,dirname)
  
}

#Enter your directory to write out the csv
ret_dat(avg_subj_act,"C:/Users/Huang Jirong/Desktop/new_datset.csv")






