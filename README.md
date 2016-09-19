# Getting-and-cleaning-data_coursera
Assignment in Getting and Cleaning Data (Coursera's Data Science Specialization)

1. First I read in x (measures), y (activity) and subjects' testing and training data, then I combine the respective testing and training datasets via the 'rbind' function.
2. Next I read in the 'features' dataset, and subset the rows in the dataset which contains either 'mean' or 'sd'.
3. With the subsetted measures ids, I'm able to select the columns in x(measures) dataset which contains either 'mean' or 'sd'.
4. As required by the question, I merge x, y and subjects dataset via cbind function.
5. Lastly, using ddply function, I created a second, independent tidy data set with the average of each variable for each activity and each subject.

Codebook for tidy data set
- subject_num: refers to the subject id
- activity: refers to each unique activity
- rest of fields: Average of fitness attributes for each activity and each subject

