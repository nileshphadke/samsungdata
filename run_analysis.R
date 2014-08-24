##Reading features.txt that contains all descriptions of various features
features<-read.csv("features.txt",sep=" ",header=FALSE, stringsAsFactors=FALSE)

##Read the train and test datasets
train<-read.csv("train\\X_train.txt",sep="",header=FALSE)
test<-read.csv("test\\X_test.txt",sep="",header=FALSE)

#Merge the train and test dataset
complete<-rbind(train,test)

##iterate over the features to find the one which are mean and standard deviation
##library(stringr)
colIndices <- numeric()
colNames <- character()
for(i in 1:nrow(features)) {
  feature <- features[i,]
  if(grepl("mean\\(\\)",feature[1,2])|grepl("std\\(\\)",feature[1,2])){
    ## do stuff with row
    #print(feature[1,2])
    colIndices<-c(colIndices,feature[1,1])
    colNames<-c(colNames,feature[1,2])
  }
}

measureVarCols <- colNames    #This will be used later

#Now we take out the subset of the columns we are interested in from the complete dataset
subsetComplete<-complete[,colIndices]

##Next we attach the subject column to the dataset
subject_train<-read.csv("train\\subject_train.txt",header=FALSE)
subject_test<-read.csv("test\\subject_test.txt",header=FALSE)
subject_complete<-rbind(subject_train,subject_test)
##subsetComplete$Subject<-subject_complete
subsetComplete<-cbind(subsetComplete,subject_complete)
colNames<-c(colNames,"Subject")

##Next we will attach activity column to the dataset
activity_train<-read.csv("train\\y_train.txt",header=FALSE)
activity_test<-read.csv("test\\y_test.txt",header=FALSE)
activity_complete<-rbind(activity_train,activity_test)
##subsetComplete$Activity<-activity_complete
subsetComplete<-cbind(subsetComplete,activity_complete)
colNames<-c(colNames,"Activity")

#Assign proper names to the columns of the dataframe
colnames(subsetComplete) <- colNames


#Assigning Activity Labels instead of the numbers (See http://www.statmethods.net/input/valuelabels.html)
activities<-read.csv("activity_labels.txt",sep=" ",header=FALSE, stringsAsFactors=FALSE)  
subsetComplete$Activity <- factor(subsetComplete$Activity,
                    levels = activities[,1],
                    labels = activities[,2])


#Next we reshape the data and compute means required for question 5 of the assignment
library(reshape2)
library(plyr)
outputDataMelt<-melt(subsetComplete,id=c("Subject","Activity"),measure.vars=measureVarCols)
outputDataMeltAggregated<-ddply(outputDataMelt,.(Subject,Activity,variable),summarize,value=mean(value))
tidyData<-dcast(outputDataMeltAggregated,Subject+Activity~variable)

#Finally we output the tidyData into a file.
write.table(tidyData, file = "tidyData.txt", row.name=FALSE)
