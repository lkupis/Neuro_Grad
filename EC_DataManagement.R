#EC Data Management
#packages
library(psych)
library(dplyr)
install.packages("lubridate")
library(lubridate)
#read in datasets
data1 <- read.csv("addHealth part 1.csv")
data2 <- read.csv("addHealth part 2.csv")
#describe datasets to inspect the data
describe(data1)
describe(data2)

total <- merge(data1,data2, by="ID") 
# 83 in ethnicity = take out, 531 

#1. income will need to be recoded into four groups (< $20,000, $20,000 - $49,999, $50,000 - $74,999, $75,000 - $100,000, and > $100,000), 
#and both psychological scales will need to be computed.
total$IncomeNew <- cut(total$Income, breaks = c(0, 20000, 50000, 75000, 100000, 104592), 
                           labels = c("<20,000", "20,000-49,999", "50,000-74,999", "75,000-100,000", ">100,000"), right = FALSE)
as.factor(total$IncomeNew)
table(total$Ethnicity)
table(total$IncomeNew)

#Clean Ethnicity data
#find rows with values outside of range
which(total[,2]>5, arr.ind = TRUE) #2 rows had values = 6
#assign naming to codes 
total$Ethnicity.f <- as.factor(total$Ethnicity)
levels(total$Ethnicity.f) <- c("Latino", # Response = "1"
                                 "African American", # Response = "2"
                                 "Asian American", # Response = "3"
                                 "American Indian", # Response = "4" 
                                 "White", #response = "5"
                                 "False"
  )




#levels(total$Ethnicity.f) <- list(1 = "Latino", 2 = "African American", 3 = "Asian American", 4 = "American Indian", 5 = "White")

#Sex data
# had to format code first by creating a new column for sex factor. If I factored before had, male (0) did not work 
which(total[,6]>1, arr.ind = TRUE)
total$Sex.f <- rep(NA, dim(total)[1])
total$Sex.f[which(total$Sex == 0)] <- "Male"
total$Sex.f[which(total$Sex == 1)] <- "Female"
as.factor(total$Sex.f)

#2. Check data to see if any items need to be recoded

total$SurveyDate<-as.Date(as.character(total$SurveyDate),format="%d/%m/%y")

#tried this code but it did't work
#total %>%
  #select(Ethnicity, BirthDate, Income, IncomeNew, Sex) %>%
 # filter(total$SurveyDate)<= as.Date("1/1/2018")

# compute self-esteem scale 
# no reverse coding in self-esteem scale - compute raw sum score- found mean of all the PF 
total$SE <- rowMeans(total[,grep("PF*", colnames(total))],na.rm = TRUE)
SEKey <- c(rep(1, 8))
SEscore <- scoreItems(keys= SEKey, items = total[,21:28], totals = FALSE, missing=TRUE, impute="none", delete=TRUE, min=NULL, max=NULL)
#was having trouble finishing this code



# compute the depression scale items FS4, FS8, FS11 and FS15 had reverse coded items - need to deal with these first
# reverse coded items 
total$FS4 <- 3 - total$FS4
total$FS8 <- 3 - total$FS8
total$FS11 <- 3 - total$FS11
total$FS15 <- 3 - total$FS15
# Get sum score of items in Depression scales
total$DEP <- rowMeans(total[,grep("FS", colnames(total))],na.rm = TRUE)
DE.scorekey <- c(rep(1,19))
DE.scorekey <- scoreItems(keys= DE.scorekey, items = total[,2:20], totals = FALSE, missing=TRUE, impute="none", delete=TRUE, min=NULL, max=NULL)

#was having trouble finishing this as well


# Get age at the day of the assessment ####
# convert dates to Posix format- this allows it to be in the format of a date
total$BirthDate_posix <- as.POSIXct(as.character(total$BirthDate), format = "%m/%d/%Y")
total$SurveyDate_posix <- as.POSIXct(as.character(total$SurveyDate), format = "%m/%d/%Y")
#Age in years- 365 day in the year to convert it to a year
total$age <- difftime(total$SurveyDate_posix, total$BirthDate_posix) / 365



# assign Fall and Spring semester categories ####

total$semester.f <- rep(NA, dim(total)[1]) #putting NA first- I tried it without doing this 
#and I found it would not work - it would put NA's for some of teh dates
# assign semester categories
total$semester.f[which(month(total$SurveyDate_posix) >= 1 & month(total$SurveyDate_posix) < 6)] <- "Spring"
total$semester.f[which(month(total$SurveyDate_posix) >= 7 & month(total$SurveyDate_posix) <= 12)] <- "Fall"
# convert to factor
total$semester.f <- as.factor(total$semester_factor) #once done then convert to factor 



# generate summary table ####
summary(total[which(total$semester.f == "Spring"),])
summary(total[which(total$semester.f == "Fall"),])


# table - I did get some help from the web and other students on creating this table 
row_names <- c("Male", "Female", "White", "Latino", "African American", "Asian American", "American Indian", 
               "< $20,000", "$20,000-$49,999", "$50,000-$74,999", "$75,000-$100,000", "> $100,000")
#Spring
spring <- filter(total)
Spring <- total[which(total$semester.f == "Spring"),]
Spring.n <- c(sum(Spring$Sex.f == "Male"),
                     sum(Spring$Sex.f == "Female"),
                     sum(Spring$Ethnicity.f == "White", na.rm = TRUE),
                     sum(Spring$Ethnicity.f == "Latino", na.rm = TRUE), 
                     sum(Spring$Ethnicity.f == "African American", na.rm = TRUE),
                     sum(Spring$Ethnicity.f == "Asian American", na.rm = TRUE),
                     sum(Spring$Ethnicity.f == "American Indian", na.rm = TRUE),
                     sum(Spring$IncomeNew == "<20,000"),
                     sum(Spring$IncomeNew == "20,000-49,000"),
                     sum(Spring$IncomeNew == "50,000-74,999"),
                     sum(Spring$IncomeNew == "75,000-100,000"),
                     sum(Spring$IncomeNew == ">100,000"))

summary(total)
Spring.P <- round(Spring.n / nrow(Spring) * 100,2) 
#Fall
Fall<- total[which(total$semester.f == "Fall"),]
Fall.n <- c(sum(Fall$Sex.f == "Male"),
               sum(Fall$Sex.f == "Female"),
               sum(Fall$Ethnicity.f == "White", na.rm = TRUE),
               sum(Fall$Ethnicity.f == "Latino", na.rm = TRUE), 
               sum(Fall$Ethnicity.f == "African American", na.rm = TRUE),
               sum(Fall$Ethnicity.f == "Asian American", na.rm = TRUE),
               sum(Fall$Ethnicity.f == "American Indian", na.rm = TRUE),
               sum(Fall$IncomeNew == "<20,000"),
               sum(Fall$IncomeNew == "20,000-49,000"),
               sum(Fall$IncomeNew == "50,000-74,999"),
               sum(Fall$IncomeNew == "75,000-100,000"),
               sum(Fall$IncomeNew == ">100,000"))
Fall.P<- round(Fall.n / nrow(Fall) * 100,2)  
Summary.t <- data.frame(Spring.n, Spring.P, Fall.n, Fall.P)
rownames(Summary.t) <- row_names
# scores in table broken down by Spring and Fall
Spring.mean <- c(round(mean(Spring$age),2),
              round(mean(Spring$DEP),2),
              round(mean(Spring$SE),2))
Spring.Ranges <- c(round(range(Spring$age),2),
                  round(range(Spring$DEP),2),
                  round(range(Spring$SE),2))

Fall.mean <- c(round(mean(Fall$age),2),
            round(mean(Fall$DEP),2),
            round(mean(Fall$SE),2))
Fall.Range <- c(round(range(Fall$age),2),
                round(range(Fall$DEP),2),
                round(range(Fall$SE),2))


#table 
print(Summary.t) #some values didn't work

#table- I then did this table to get the rest of the values
summary(total[which(total$semester.f == "Spring"),])
summary(total[which(total$semester.f == "Fall"),])

