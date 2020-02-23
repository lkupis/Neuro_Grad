d = read.table("HW7.dat", header = TRUE)
summary(d)
library(car)
library(psych)
library(ggplot2)
#that participants’ attitudes will be more polarized (or extreme) following group discussion of the 
#target topic than discussion
#of an irrelevant topic or no discussion at all, 
#and the latter two conditions do not differ in their level of polarization.

#univariate statistics (mean, median, mode, SD etc.)
describe(d) 
describeBy(d$Cond,list(d$Polarization, d$Duration))
summaryBy(Polarization ~ Cond, FUN = mean,data= d)
summaryBy(Duration ~ Cond, FUN = mean,data= d)
#histogram of condition
d %>%
  ggplot(aes(Cond)) +
  geom_histogram(binwidth = .5, color = "black",fill = "grey") +
  geom_vline(xintercept = mean(d$Cond)) +
  labs(title = "Distribution of Cond",
       x = "Cond",
       y = "#") +
  theme_minimal() 
#histogram of polarization
d %>%
  ggplot(aes(Polarization)) +
  geom_histogram(binwidth = .5, color = "black",fill = "grey") +
  geom_vline(xintercept = mean(d$Polarization)) +
  labs(title = "Distribution of polarization",
       x = "Polarization",
       y = "#") +
  theme_minimal() 
str(d) 
as.factor(d$Cond)
ggplot(data = d) +
  geom_histogram(mapping = aes(x = Polarization), bins = 5)
# polarization by condition plot
plot(d$Cond,d$Polarization,xlab="condition",ylab="Polarization") 
#polarization by Duration plot
plot(d$Cond,d$Duration,xlab="Duration",ylab="Polarization")
#polarization by condition
mean(d$Polarization)
#Mean Center Duration
d$Durationcenter = d$Duration -mean(d$Duration)
#change condition to factor
d$Cond<- as.factor(d$Cond)
levels(d$Cond)
#set contrasts
c1<- c(.66667, -.3333, -.3333)
c2<- c(0,.5,-.5)
contrasts(d$Cond) <- cbind(c1,c2)
contrasts(d$Cond)


#C1vC2 model 
C1vC2 = lm(d$Polarization ~Cond + Durationcenter, data = d)
summary(C1vC2)
modelSummary(C1vC2)
Anova(C1vC2, Type = 3) # not necessary for interpretation
modelEffectSizes(C1vC2)
plot(C1vC2)


