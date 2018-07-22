#setting the working directory
setwd("/cloud/project/Machine Learning A-Z Template Folder/Part 1 - Data Preprocessing")

#reading/importing the csv file
dataset=read.csv('Data.csv')

#print column Age to the console
#dataset$Age

#deal with missing data
#replacing NaN values with the average of that column
#the way that this goes is: if we have a NaN value in column Age, apply a column mean and put that value instead of NaN
dataset$Age=ifelse(is.na(dataset$Age),
                   ave(dataset$Age, FUN = function(x) mean(x, na.rm=TRUE)),
                   dataset$Age)

dataset$Salary=ifelse(is.na(dataset$Salary),
                      ave(dataset$Salary, FUN = function(x) mean(x, na.rm=TRUE)),
                      dataset$Salary)

#Categorical data
#Categorize variables: instead of categories (names), turn this into numbers instead
#select the column where you want to do this, put what you want to change from, put what you want to replace to.
dataset$Country=factor(dataset$Country,
                       levels=c('France','Spain','Germany'),
                       labels=c(1,2,3))

dataset$Purchased=factor(dataset$Purchased,
                         levels=c('No','Yes'),
                         labels=c(0,1))

#splitting data set into training/testing data sets
#import caTools livrary - used to split the data into trainning/test set
library(caTools)

#use a random number seed (so I get the same results as the udemy guy)
set.seed(123)

#cria um vector de Booleanos de dimensao igual ao inputado (dataset$Purchased) 
#one (neste caso 80%) dos Booleanos sao TRUE e os restantes (20%) sao FALSE
split=sample.split(dataset$Purchased,SplitRatio=0.8)

#aplica este vector de booleanos ao subset e splita o subset em training/testing _set
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)

#feature scaling:como tenho diferentes variaveis com diferentes magnitudes preciso de as normalizar
#so vou normalizar as variaveis que sao numeros (Country e Purchased como )
training_set[,2:3]=scale(training_set[,2:3])
test_set[,2:3]=scale(test_set[,2:3])
