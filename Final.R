library(psych)
library(dplyr)
library(lmSupport)
library(car)
d = read.table("catsNdogs.dat", header = TRUE)
str(d)
describe(d)
describe(d$Species)
#mean by condition
d %>% filter(Condition == 0) %>% select(Score) %>%
  describe(d$Score)
d %>% filter(Condition == 1) %>% select(Score) %>%
  describe(d$Score)
#find mean scores of dogs
d %>% filter(Species == 0) %>% select(Score) %>%
  describe(d$Score)
#describe mean scores by dog, then condition 0
d %>% filter(Species == 0) %>% filter(Condition == 0) %>% select(Score) %>%
  describe(d$Score)
#describe mean scores by dog, then condition =1
d %>% filter(Species == 0) %>% filter(Condition == 1) %>% select(Score) %>%
  describe(d$Score)
#find mean scores of cats
d %>% filter(Species == 1) %>% select(Score) %>%
  describe(d$Score)
#find mean scores of cats in condition 0 
d %>% filter(Species == 1) %>% filter(Condition == 0) %>% select(Score) %>%
  describe(d$Score)
#find means scores for cats in condition 1
d %>% filter(Species == 1) %>% filter(Condition == 1) %>% select(Score) %>%
  describe(d$Score)
# SummaryBy(Score~Condition, FUN = c(length, mean),data = d)
#histogram of species
hist(d$Species, xlab = "Species", ylab = "Amount", main =
       "Histogram of Dogs and Cats")
#histogram of the scores
hist(d$Score, xlab = "Scores", ylab = "Frequency", main =
       "Histogram of Scores")
d %>% filter(Species == 0) %>% select(Score) %>% hist(Score, xlab = "Species", ylab = "Score", main =
       "Histogram of Dogs")

#models
#recode
#d$Species = as.factor(d$Species)
#levels(d$Species)
#d$Condition = as.factor(d$Condition)
#levels(d$Condition)
d$C1 = recode(d$Species, "'0' = -.5; '1'=.5")
d$C2 = recode(d$Condition,"'0' = -.5; '1'=.5")
mA <- lm(formula = Score ~ C1*C2, data = d)
#mA2 <- lm(Score ~ Species*Condition, data = d)
summary(mA)
anova(mA)

model.means <- interactionMeans(mA) #combinations of 2 factors

model.means

# gives interaction plots
plot(model.means)

#Simple Effects
#as.factor
d$C2A = recode(d$Species, "'0' = 0; '1'= 1")
d$C3 = recode(d$Condition,"'0' = 0; '1'= 1")
levels(d$C2A)
levels(d$C3)
d$Species = as.factor(d$Species)
#levels(d$Species)
d$Condition = as.factor(d$Condition)
mA2 <- lm(Score ~ Species*Condition, data = d)
summary(mA2)
anova(mA2)



library(doBy)
library(phia)
#which model do I use here? mA or mA2? - since one is ME one is SE
testInteractions(mA, fixed = "Condition", across = "Species", adjustment="none")
testInteractions(mA)
testInteractions(mA2, fixed = "Condition", across = "Species", adjustment="bonferroni")



#study 2
c = read.csv("catsrace.csv", header = TRUE)
str(c)
describe(c)
#boxplot distance
boxplot(c$distance)
#boxplot time
boxplot(c$time)
#98 and 110
#model
c$loved<- as.factor(c$loved)
levels(b$loved)
#set contrasts
c4<- c(.3333,-.66667, .3333)
c5<- c(.5,0,-.5)
contrasts(c$loved) <- cbind(c4,c5)
contrasts(c$loved)
#model
mA3 = lm(time ~loved, data = c)
summary(mA3)
modelSummary(mA3)

#Anova(mA3 Type = 3) # not necessary for interpretation
#redo with new data

mA4 = lm(time ~loved + distance, data = c)
summary(mA4)
modelSummary(mA4)
#check the averages
c %>% filter(loved == "loved") %>% describe(c$time) 
c %>% filter(loved == "disliked") %>% describe(c$time)
c %>% filter(loved == "neutral") %>% describe(c$time) 


# 
#rerun new dataset without outliers
b= read.csv("catsrace2.csv", header = TRUE)
b$loved<- as.factor(b$loved)
levels(b$loved)

# find the simple means and marginal means
b %>% filter(loved == "loved") %>% describe(b$time)
b%>% filter(loved == "disliked") %>% describe(b$time)
b %>% filter(loved == "neutral") %>% describe(b$time) 
b %>% filter(loved == "loved") %>% filter(environment == .5) %>% describe(b$time)
b %>% filter(loved == "loved") %>% filter(environment == -.5) %>% describe(b$time)
b %>% filter(loved == "disliked") %>% filter(environment == .5) %>% describe(b$time)
b %>% filter(loved == "disliked") %>% filter(environment == -.5) %>% describe(b$time)
b %>% filter(loved == "neutral") %>% filter(environment == .5) %>% describe(b$time)
b %>% filter(loved == "neutral") %>% filter(environment == -.5) %>% describe(b$time)
#set contrasts
c6<- c(.3333,-.66667, .3333)
c7<- c(.5,0,-.5)
contrasts(b$loved) <- cbind(c6,c7)
contrasts(b$loved)
#model
mA5 = lm(time ~loved, data = b)
summary(mA5)
modelSummary(mA5)
#Anova(mA3 Type = 3) # not necessary for interpretation
#redo with new data

mA6 = lm(time ~loved + distance, data = b)
summary(mA6)
modelSummary(mA6)


#use these to test hypothesis 2 and 3
#Anova(mA4 Type = 3) # not necessary for interpretation
mA7 <- lm(time~environment*loved, data = b)
levels(b$loved)
str(b)
summary(mA7)
#control for distance
mA8 <- lm(time~environment*loved + distance, data = b)
summary(mA8)
Anova(mA8, type =3)
modelEffectSizes(mA8)

#tried a different way- to check if supposed to use dummy coding
e= read.csv("catsrace2.csv", header = TRUE)
#e$loved<- as.factor(e$loved)
#levels(e$loved)
str(e)
mA7 <- lm(time~environment*loved, data = e)
summary(mA7)
#control for distance
mA8 <- lm(time~environment*loved + distance, data = e)
summary(mA8)
Anova(mA8, type =3)
modelEffectSizes(mA8)
