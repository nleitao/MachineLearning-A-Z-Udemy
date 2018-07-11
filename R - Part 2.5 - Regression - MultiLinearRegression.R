# Data Preprocessing Template

# Importing the dataset
dataset = read.csv('50_Startups.csv')

#Categorical data
#Categorize variables: instead of categories (names), turn this into numbers instead
#select the column where you want to do this, put what you want to change from, put what you want to replace to.
dataset$State=factor(dataset$State,
                     levels=c('New York','California','Florida'),
                     labels=c(1,2,3))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

#Fitting Multiple Linear Regression to the Training set
#I need to say that the profit is going to be a linear combination of the independent variables
#posso escrever isto dizendo que profit ~ IV1+IV2+etc... ou profit ~ .   . R percebe que este . (dot) e igual as remaining colunas
#regressor=lm(formula=Profit~ R.D.Spend + Administration + Marketing.Spend + State)
regressor=lm(formula=Profit ~ .,
             data=training_set)

summary(regressor)
#escrever na console summary(regressor) para ver mais informacoes sobre este regressor,
#por exemplo pra ver que variaveis tem um p score menor (variaveis significantes)

#Predicting the test set results
y_pred=predict(regressor, newdata=test_set)

#######BACKWARD ELIMINATION
#Aqui apliquei o algoritmo "Backward Elimination": Ou seja, comecei por fazer uma regressao com todas as variaveis e fui fazendo o summary(regressor)
#para achar a variavel com maior p score superior ao significant level (neste caso escolhi 0.05) (ou seja, que nao é estatisticamente significante), removi essa variavel e apliquei o algoritmo outra vez.
#Na primeira iteracao removi o State, dps outra variavel e outra e acabei so com o R.D.Spend.

#Building the optimal model using Backward Elimination
#como exemplo so, aqui comecei com todas...
regressor=lm(formula=Profit~ R.D.Spend + Administration + Marketing.Spend + State,
             data=dataset)

summary(regressor)
#dps de fazer o summary retirei o State porque tinha o p value maior e superior ao SL=0.05

regressor=lm(formula=Profit~ R.D.Spend + Administration + Marketing.Spend,
             data=dataset)
summary(regressor)

#repeti tudo e acabei so com uma variavel R.D.Spend

regressor=lm(formula=Profit~ R.D.Spend,
             data=dataset)