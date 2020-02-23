library("tidyverse")
cogFlex_Data <- read.csv("Usable_Subjects_Excluded_10.14.2019.csv")
summary(cogFlex_Data)
#cogFLex_Data1 <- na.omit(cogFlex_Data)
summary(cogFlex_Data)
ASD_Cases <- subset(cogFlex_Data,cogFlex_Data$Diag_ASD == 1)
TD_Cases <- subset(cogFlex_Data,cogFlex_Data$Diag_ASD == 0)
summary(ASD_Cases)
summary(TD_Cases)
#ASD_Cases %>% filter(ASD_Cases$Gender==1) %>% nrow(ASD_Cases$Gender)
library("tidyverse")
Rest_FD <- read.table(file = 'Rest_HeadMotion.tsv', sep = '\t', header = TRUE)
Task1_FD <- read.table(file = 'Task1_HeadMotion.tsv', sep = '\t', header = TRUE)
Task2_FD <- read.table(file = 'Task2_HeadMotion.tsv', sep = '\t', header = TRUE)
Task3_FD <- read.table(file = 'Task3_HeadMotion.tsv', sep = '\t', header = TRUE)
Task4_FD <- read.table(file = 'Task4_HeadMotion.tsv', sep = '\t', header = TRUE)
?read.csv
FD_All <- read.csv(file = 'FD_All_new_Exluded_Subjects_10.14.2019.csv', sep = ',', header=TRUE)
FD_All[FD_All == "N/A"] <- NA
as.numeric(as.character(FD_All$Task2_FD))
as.numeric(as.character(FD_All$Task3_FD))
as.numeric(as.character(FD_All$Task4_FD))
na.omit(FD_All)
mean(FD_All$Task4_FD, na.rm= TRUE)
FD_dx_TD <- subset(FD_All, FD_All$dx == 0, na.rm =TRUE)
str(FD_All)
na.omit(FD_dx_TD)
mean(FD_dx_TD$Task4_FD, na.rm= TRUE)
install.packages("psych")

library(psych)
FD_dx_ASD <- subset(FD_All, FD_All$dx == 1, na.rm = TRUE)
describe(FD_dx_ASD, na.rm = TRUE)
help(t.test)

boxplot(FD_dx_ASD, na.rm = TRUE)
boxplot(FD_dx_TD, na.rm = TRUE)
#TD
TD_Rest <- FD_dx_TD$Rest_FD
mean(TD_Rest)
TD_Task1 <- FD_dx_TD$Task1_mean.FD_Power
TD_Task2 <- FD_dx_TD$Task2_FD
TD_Task3 <- FD_dx_TD$Task3_FD
TD_Task4 <- FD_dx_TD$Task4_FD
#ASD
ASD_Rest <- FD_dx_ASD$Rest_FD
ASD_Task1 <- FD_dx_ASD$Task1_mean.FD_Power
ASD_Task2 <- FD_dx_ASD$Task2_FD
ASD_Task3 <- FD_dx_ASD$Task3_FD
ASD_Task4 <- FD_dx_ASD$Task4_FD
#box plots
boxplot(ASD_Rest, TD_Rest, na.rm = TRUE)
boxplot(ASD_Task1, TD_Task1, na.rm = TRUE)
boxplot(ASD_Task2, TD_Task2, na.rm = TRUE)
boxplot(ASD_Task3, TD_Task3, na.rm = TRUE)
boxplot(ASD_Task4, TD_Task4, na.rm = TRUE)

#T Test ASD V TD 
?t.test()
ttest_rest <- t.test(ASD_Rest, TD_Rest)
ttest_rest
ttest_Task1 <- t.test(ASD_Task1, TD_Task1)
ttest_Task1
ttest_Task2 <- t.test(ASD_Task2, TD_Task2)
ttest_Task2
ttest_Task3 <- t.test(ASD_Task3, TD_Task3)
ttest_Task3
ttest_Task4 <- t.test(ASD_Task4, TD_Task4)
ttest_Task4

#Each Task Comparison Within Group. Paired? 
#ASD Rest v Tasks
ttest_ASDRv1 <- t.test(ASD_Rest, ASD_Task1, paired = TRUE)
ttest_ASDRv1
ttest_ASDRv2 <- t.test(ASD_Rest, ASD_Task2, paired = TRUE)
ttest_ASDRv2
ttest_ASDRv3 <- t.test(ASD_Rest, ASD_Task3, paired = TRUE)
ttest_ASDRv3
ttest_ASDRv4 <- t.test(ASD_Rest, ASD_Task4, paired = TRUE)
ttest_ASDRv4
#ASD Task v Task
ttest_1v2 <- t.test(ASD_Task1, ASD_Task2, paired = TRUE)
ttest_1v2
ttest_1v3 <- t.test(ASD_Task1, ASD_Task3, paired = TRUE)
ttest_1v3
ttest_1v4 <- t.test(ASD_Task1, ASD_Task4, paired = TRUE)
ttest_1v4
ttest_2v3 <- t.test(ASD_Task2, ASD_Task3, paired = TRUE)
ttest_2v3
ttest_2v4 <- t.test(ASD_Task2, ASD_Task4, paired = TRUE)
ttest_2v4
ttest_3v4 <- t.test(ASD_Task3, ASD_Task4, paired = TRUE)
ttest_3v4
# TD 
#Each Task Comparison Within Group. Paired? 
#TD Rest v Tasks
TDttest_TDRv1 <- t.test(TD_Rest, TD_Task1, paired = TRUE)
TDttest_TDRv1
TDttest_TDRv2 <- t.test(TD_Rest, TD_Task2, paired = TRUE)
TDttest_TDRv2
TDttest_TDRv3 <- t.test(TD_Rest, TD_Task3, paired = TRUE)
TDttest_TDRv3
TDttest_TDRv4 <- t.test(TD_Rest, TD_Task4, paired = TRUE)
TDttest_TDRv4
#TD Task v Task
TDttest_1v2 <- t.test(TD_Task1, TD_Task2, paired = TRUE)
TDttest_1v2
TDttest_1v3 <- t.test(TD_Task1, TD_Task3, paired = TRUE)
TDttest_1v3
TDttest_1v4 <- t.test(TD_Task1, TD_Task4, paired = TRUE)
TDttest_1v4
TDttest_2v3 <- t.test(TD_Task2, TD_Task3, paired = TRUE)
TDttest_2v3
TDttest_2v4 <- t.test(TD_Task2, TD_Task4, paired = TRUE)
TDttest_2v4
TDttest_3v4 <- t.test(TD_Task3, TD_Task4, paired = TRUE)
TDttest_3v4



# anova() l 2 x 3 mixed-model ANOVA looking at a group (between: ASD,TD) x scan (within: rest, run1, run2, run 3, run 4) interaction. 
model = aov(ASD_Cases ~ TD_Cases + Rest_FD + Task1_FD + Task2_FD + Task3_FD + Task4_FD)
summary(model)
?lm

FD_All <- read.csv(file = 'FD_All_new_Exluded_Subjects_10.14.2019.csv', sep = ',', header=TRUE)
str(FD_All)
FD_All$dx <- as.factor(FD_All$dx)
FD_All$ASD <- (FD_All$dx == 1)
FD_All$TD <- (FD_All$dx == 0)
AnovaFD <- lm(Rest_FD ~ dx, data = FD_All)
summary(AnovaFD)


#t test to compare gender, age, and IQ
gender_ASD <- ASD_Cases$Gender
gender_TD <- TD_Cases$Gender
t.test(gender_ASD,gender_TD)
library(psych)
summary(ASD_Cases$Gender)

Age_ASD<- ASD_Cases$Age2
Age_TD <- TD_Cases$Age2
t.test(Age_ASD,Age_TD)

mean(Age_ASD)
mean(Age_TD)
SD(Age_ASD)
SD(Age_TD)

IQ_ASD<- ASD_Cases$WASI_2..WASI_FSIQ4_CS
IQ_TD <- TD_Cases$WASI_2..WASI_FSIQ4_CS
t.test(IQ_ASD,IQ_TD)
mean(IQ_ASD)
SD(IQ_ASD)
mean(IQ_TD,na.rm= TRUE)
SD(IQ_TD,na.rm= TRUE)
str(TD_Cases$WASI_2..WASI_FSIQ4_CS)

BI_ASD<-ASD_Cases$BRIEF..Brief_InhibitTS
BI_TD<- TD_Cases$BRIEF..Brief_InhibitTS
t.test(BI_ASD,BI_TD)
mean(BI_ASD)
SD(BI_ASD)
mean(BI_TD)
SD(BI_TD)

BS_ASD<-ASD_Cases$BRIEF..Brief_ShiftTS
BS_TD<- TD_Cases$BRIEF..Brief_ShiftTS
t.test(BS_ASD,BS_TD)
mean(BS_ASD)
SD(BS_ASD)
mean(BS_TD)
SD(BS_TD)


BE_ASD<-ASD_Cases$BRIEF..Brief_EmotionalControlTS
BE_TD<- TD_Cases$BRIEF..Brief_EmotionalControlTS
t.test(BE_ASD,BE_TD)
mean(BE_ASD)
SD(BE_ASD)
mean(BE_TD)
SD(BE_TD)

BGEC_ASD<-ASD_Cases$BRIEF..Brief_GEC_TS
BGEC_TD<- TD_Cases$BRIEF..Brief_GEC_TS
t.test(BGEC_ASD,BGEC_TD)
mean(BGEC_ASD)
SD(BGEC_ASD)
mean(BGEC_TD)
SD(BGEC_TD)








