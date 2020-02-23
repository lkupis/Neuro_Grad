library("stats")
install.packages("ggplot2")
library("ggplot2")
install.packages("psych")
library("psych")
install.packages("magrittr")
library("magrittr")
install.packages("diplyr")
library("diplyr")
install.packages("devtools")
library("devtools")
#1.	Read in the data and inspect them (summaries, structure, descriptive stats)
#After setting the working directory, the following should do the trick:
d <- read.csv("stray_animals.csv", sep=",", header=T) 
summary(d)
describe(d)
str(d)
#2.	Create an appropriate plot that shows whether the number of stray dogs in year one varies as a function 
#of the number of animal shelters in the state. 
#Copy and paste this graph into your word document.
plot(x=d$Shelters, y=d$Dogs1 , xlab="Number of Shelters", ylab="Number of Dogs in Year 1", main="Scatter Plot of Dogs Year 1 V Animal Shelters")

#2a.	Add a best fitting line.
abline(lm(d$Dogs1~d$Shelters)) 

dcorr <- c('Dogs1', 'Shelters')
dcorrdata <- d[,dcorr]
corr.test(dcorrdata)

#3.	Go through the following steps to create a composite score that reflects the overall numbers of stray animals, 
#referred to as the “stray index” in these questions:
#3a.	Standardize the measures for stray dogs in year 1, stray cats in year 1, 
#and other stray animals in year 1, individually.
d$Standard_Dogs1 <- scale(d$Dogs1)
d$Standard_Cats1 <- scale(d$Cats1)
d$Standard_Other <- scale(d$Other)
#3b.	Check to make sure you standardized these variables correctly.
# Dogs1: 
zscore_Dogs <- (d$Standard_Dogs1-mean(d$Standard_Dogs1)/sd(d$Standard_Dogs1))
print(zscore_Dogs)
describe(zscore_Dogs)
describe(d$Standard_Dogs1)
#Cats1:
zscore_Cats <- (d$Standard_Cats1-mean(d$Standard_Cats1)/sd(d$Standard_Cats1))
print(zscore_Cats)
describe(zscore_Cats)
describe(d$Standard_Cats1)
#Other
zscore_Other <- (d$Standard_Other-mean(d$Standard_Other)/sd(d$Standard_Other))
print(zscore_Other)
describe(zscore_Other)
describe(d$Standard_Other)
#3c.Before making a composite score, we need to know whether it makes sense to combine these three variables and use 
#them as a single measure. 
#You check and see that the alpha reliability = .89. Comment on the reliability. Should we consider dropping 
#any of these groups from the stray index? Which one(s)? For now, don’t drop any. 
combinedAnimals <- d[c("Cats1", "Dogs1", "Other")]
alpha(combinedAnimals)
#std.alpha = .89 = standardised alpha based upon the correlations
#3d.	Create a new variable (Strays1) representing the average of these standardized scores.
#d$Strays1 <- rowMeans(cbind(d$Standard_Cats1, d$Standard_Dogs1, d$Standard_Other))
d$Strays1 <- (d$Standard_Cats1 + d$Standard_Dogs1 + d$Standard_Other)/3


#4.	Create a histogram of the number of stray cats in year 1. Do the same thing for the number of stray cats in year 5. 
#Copy and paste the graphs into your word document.
hist(d$Cats1,xlab = "Cats in Year 1",ylab = "Frequency",main="Histogram of Stray Cats in Year 1")
hist(d$Cats5,xlab="Cats in Year 5",ylab = "Frequency",main="Histogram of Stray Cats in Year 5")

#5.	Create a variable that represents the change in number of stray cats from year 1 to year 5. Name this variable “CatsChange.”
d$CatsChange <- d$Cats5 - d$Cats1

#6. What is the formula for each of the two models you should compare if you want to know whether 
#the change in the number of stray cats is different from zero? Compact and augmented
#modA = lm(CatsChange ~ 1, data = d) #augmented
#modC = lm(CatsChange ~ 0, data = d) #compact

d$Predict0 = 0 #null
d$Predict1 = mean(d$CatsChange) #using the mean
#7.	Compute the SSE for each model using a step-by-step brute force method, 
#like we did in lecture. Remember to label clearly (SSE0, SSE1). 
#SSE0
SSE0 = sum((d$CatsChange -d$Predict0)^2)
SSE0
#SSE1
d$Errors1=d$CatsChange - d$Predict1
d$SquErr1=d$Errors1*d$Errors1 
SSE1=sum(d$SquErr1)
SSE1
mean(d[,"CatsChange"]) #-1.1
#8.	Compare the two models by calculating the F statistic and p value (also the slow version like we did in lecture). 
#Which model is better? Why? Interpret the result in plain English 
#(i.e., what does the result say regarding the effectiveness of the program?)
#F stat 
n = nrow(d)
Fstat = ((SSE0 - SSE1)/(1 - 0))/(SSE1/(n-1))
Fstat
#p value
dfN = 1-0
dfD = n -1
pf(Fstat, dfN, dfD, lower.tail = FALSE)

#9.	Even though there was no targeted program to change the number of stray dogs between year 1 and year 5, 
#the researchers are curious to see if the number of stray dogs changed during that period. 
#Create a variable to represent this change in the number of stray dogs. 
d$DogsChange <- d$Dogs5 - d$Dogs1

#10.	Using the lm command, estimate the simple model (mean-only) for the change in the number of stray dogs.
modADogs = lm(d$DogsChange ~ 1, data = d) #augmented or mean only model
summary(modADogs)


#10 a.	What does the b0 value represent?
#Intercept = .48

#10 b.	What does the significance test of the b0 mean?

#10 c.	This command is implicitly telling R to do a model comparison. What are the two models being compared?
modADogs = lm(d$DogsChange ~ 1, data = d)
modCDogs = lm(d$DogsChange ~ 0, data = d) #compact
anova(modADogs, modCDogs)

  





