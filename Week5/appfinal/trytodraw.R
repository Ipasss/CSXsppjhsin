#Load packages and dataset
library(ggplot2)
library(ggthemes)
library(psych)
library(relaimpo)
all <- read.csv("~/Documents/GitHub/CSXsp/Week5/all.csv")
#資料依成績由小到大排序
all_ordered <- all[order(all$score),]
#crimerate vs score
cor(all_ordered$score,all_ordered$`crime rate`)
cor(all_ordered$score,all_ordered$internet)
cor(all_ordered$score,all_ordered$democracy)

ggplot((all_ordered, aes(x = `crime rate`, y = score)) +
  geom_point() + coord_flip() +
  labs( y = 'score', x = 'crime rate', 
        title = 'crimerate vs score')
  
ggplot(all_ordered, aes(x = all_ordered$crime.rate, y = all_ordered$score)) +
  geom_line() + 
  labs( y = "score", x = "crimerate", title = 'crimerate vs score')

ggplot(all_ordered, aes(y = all_ordered$crime.rate, x = all_ordered$score)) +
  geom_line() + 
  labs( x = "score", y = "crimerate", title = 'crimerate vs score')

model <- lm(formula= all_ordered$score ~ all_ordered$crime.rate + all_ordered$internet + all_ordered$democracy,
            )
summary(model)