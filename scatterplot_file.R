#write scatter plot script
library(ggplot2)
#install.packages('easyGgplot2')
library(psych)
#install.packages("readxl")
library(readxl)
d <- read_excel('DT_Correlations.xlsx')
describe(d)
str(d)
#as.numeric('Rest_5_DT')
#as.numeric('SRS_Total')
#as.factor('dx')
#levels('dx')
str(d$dx)
d$dx <- as.factor(d$dx)
#ggplot(d, aes(x = 'rest_5_DT', y = 'SRS_Total')) +
  
  my_graph <- ggplot(d, aes(x = Rest_5_DT, y = SRS_Total)) +
  geom_point(aes(col=c("blue","red")[dx]),shape=1, size=3,alpha=1) + geom_smooth(method = lm)
  
  #geom_point() + geom_smooth(method = lm) +
  #stat_smooth(method = "lm",
           #   col = "#49494D",
          #    se = FALSE,
           #   size = 1) + scale_color_manual(values=c("#E3655B", "#4FB0C6")) + labs(color="Dx")

my_graph + labs(
                x = " Rest CAP5", y = "SRS"
)    +
  theme(panel.grid.major = element_blank(),
           panel.grid.minor = element_blank(),
           panel.border = element_blank(),
           panel.background = element_blank(),
           axis.line.x = element_line(color="black", size = .25),
           axis.line.y = element_line(color="black", size = .25))
#+ theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                      #  panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
my_graph



my_graph
ggsave("my_graph_bydx_confint_new.png")
                 





#version 2 of the graph= separate dx by color with different confidence intervals

my_graph <- ggplot(d, aes(x = Rest_5_DT, y = SRS_Total, color=factor(d$dx, labels = c("ASD", "TD")))) +
  geom_point(aes(color = dx, shape=dx)) + 
  geom_smooth(aes(color = dx, fill = dx), method = lm) +
  scale_color_manual(values = c("#FC4E07", "#00AFBB" ))+
  scale_fill_manual(values = c("#FC4E07", "#00AFBB" )) +
  labs(color="Dx")

my_graph + labs(
  x = " Rest CAP5", y = "SRS"
)  + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
my_graph + geom_point()

#+ theme(legend.position = c(.9,.9))
my_graph
ggsave("my_graph_new_confidence_intervals2.png")






# Bar graphs for DT and Frequency

# Bar graphs for DT and Frequency

# Libraries
library(ggplot2)
library(dplyr)
library(forcats)
library(hrbrthemes)
library(viridis)
library(tidyr)
library(ggplot2)
library(dplyr)
# Load dataset from github
d1 <- read_excel('DT_CAP3_forR.xlsx')
d1$dx <- as.factor(d$dx)
A<- gather(d1, "DT", "Cases", 2:6)
#what you need for the graph
dodge <- position_dodge(width=.4)
new1 <- c("Rest", "Task Run 1", "Task Run 2", "Task Run 3", "Task Run 4")
new2 <- c("ASD", "TD")
select(A,dx=1)
A <- gather()
#violin plot
Aplot <- ggplot(A, aes(x=DT, y=Cases, fill=dx)) +
  geom_violin(adjust =.5, position = dodge) +
  geom_boxplot(width =.1, outlier.colour=NA, position = dodge)
Aplot + scale_x_discrete(labels = new1) + theme_bw(base_size = 16) + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                                             panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) 
ggsave("violin_plot_DT_new3.png")



#seperate plots
ggplot(d1, aes(x = dx, y = Task1_3_DT, color =dx)) + 
  geom_violin(adjust = .5)+
  geom_boxplot(width=.1)

ggplot(d1, aes(x = dx, y = Task2_3_DT, color =dx)) + 
  geom_violin(adjust = .5)+
  geom_boxplot(width=.1)

ggplot(d1, aes(x = dx, y = Task3_3_DT, color =dx)) + 
  geom_violin(adjust = .5)+
  geom_boxplot(width =.1)

ggplot(d1, aes(x = dx, y = Task4_3_DT, color =dx)) + 
  geom_violin(adjust = .5)+
  geom_boxplot(width =.1)



# Frequency Plot
d2 <- read_excel('Freq_Sig_forR.xlsx')
d2$dx <- as.factor(d2$dx)

#what you need for the graph
dodge <- position_dodge(width=.4)
new1 <- c("Rest", "Task Run 1", "Task Run 2", "Task Run 3", "Task Run 4")
new2 <- c("ASD", "TD")
B<- gather(d2, "Frequency", "Cases", 2:6)
#violin plot
Bplot <- ggplot(B, aes(x=Frequency, y=Cases, fill=dx)) +
  geom_violin(adjust =.5, position = dodge) +
  geom_boxplot(width =.1, outlier.colour=NA, position = dodge)
Bplot + theme_bw(base_size = 16) + scale_x_discrete(labels = new1) + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                                                             panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) 
ggsave("violin_plot_Freq_new4.png")
