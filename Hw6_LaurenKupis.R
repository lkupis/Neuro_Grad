d = read.table("HW7.dat", header = TRUE)
summary(d)
describe(d) # checked the code to check teh codes
#that participants’ attitudes will be more polarized (or extreme) following group discussion of the 
#target topic than discussion
#of an irrelevant topic or no discussion at all, 
#and the latter two conditions do not differ in their level of polarization.
library(ggplot2)
d %>%
  ggplot(aes(Cond)) +
  geom_histogram(binwidth = 1.25, color = "black",fill = "grey") +
  geom_vline(xintercept = mean(d$Cond)) +
  labs(title = "Distribution of polarization in Cond",
       x = "Cond",
       y = "Polarizaiton") +
  theme_minimal() 

str(d) 
as.factor(d$Cond)

m1 <- lm(Polarization ~ Cond, data = d)
#Cond 1 and 2 
summary(m1)
anova(m1)
modelEffectSizes(m1)

m2 <- lm(Polarization ~ Cond*Duration, data = d)
#Cond 1 and 2 
summary(m2)
anova(m2)
modelEffectSizes(m2)

m3 <- lm(Polarization ~ Cond + Duration, data = d)
#Cond 1 and 2 
summary(m3)
anova(m3)
modelEffectSizes(m3)
