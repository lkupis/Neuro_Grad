library(psych)
install.packages("pwr")
library("pwr")
#1.	Before running any analyses, assume based on past research that the 
#effect of beverage group on anxiety has an effect size of d =.4. Given your 
#sample size of 96 and assuming equal n per group, use the pwr.t.test function in 
#the pwr package in R to determine your power to detect an effect of this size.
pwr.t.test(n = 48, d = .4, sig.level = .05, type = "two.sample", 
           alternative = "two.sided") 

#Read in and run descriptive statistics on the data overall and by each 
#Beverage Group (you don’t need to show any code or output for this part).
data <- read.delim("HW4_Data.dat", sep="")
summary(data)
describe(data)
install.packages("dplyr")
describeBy(d$BG)
library("dplyr")



#2.	First test to see if the two beverage groups already differ on their
#anxiety about receiving a shock before receiving their respective beverages
#(at baseline). Fit a linear model to test this question. Report the corresponding
#t-statistic, df and p-value and describe the result of the model in words. 
AnxBaseM <- lm(AnxBase ~ BG, data = data)
summary(AnxBaseM)
  ?summary
#4.	Fit a linear model predicting anxiety (not baseline anxiety)
#from beverage group. 
#Test if beverage group significantly predicts anxiety
#(report t-statistic, df, and p-value) and provide a 95% confidence interval for the parameter estimate. 
#Describe the effect of beverage group on anxiety in a sentence.
AnxTestM = lm(AnxTest ~ BG, data = data) 
summary(AnxTestM)
confint(AnxTest, level = .95)
#etaSquared(AnxTestM)
#install.packages("lsr")
#library("lsr")
#5.	Report p2 (PRE) along with its interpretation in a sentence to describe the effect of beverage group.

#6.	Write a concise summary of the results (a few sentences). Explain the hypothesis you tested, 
#the statistical results of your test, and the practical interpretation of the result. 
