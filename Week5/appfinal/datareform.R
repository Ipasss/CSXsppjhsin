College_ranking <- read_csv("~/Documents/GitHub/CSXsp/Week5/College_ranking.csv")
str(College_ranking)
summary(College_ranking)
data_2012 <- subset(College_ranking, year==2012)
data_2013 <- subset(College_ranking, year==2013)
data_2014 <- subset(College_ranking, year==2014)
data_2014 <- data_2014[-(101:999),]
data_2015 <- subset(College_ranking, year==2015)
data_2015 <- data_2015[-(101:999),]
as.numeric(College_ranking$world_rank)
College_ranking2 <- College_ranking %>% filter("world_rank"<=100)
College_ranking100 <- College_ranking[-c((301:1200),(1301:2200)),]
write.csv(College_ranking100, "College_ranking100.csv", row.names = FALSE)

ggplot(College_ranking,aes(College_ranking$institution,College_ranking$world_rank)) + geom_point(
  
)

College_ranking <- read.csv("~/Documents/GitHub/CSXsp/Week5/College_ranking.csv", stringsAsFactors = F, na.strings = c("NA", ""))
College_ranking <- College_ranking %>% filter(world_rank <=100)
rank_2012 <- rank[College_ranking$year == "2012",]
rank_2013 <- rank[College_ranking$year == "2013",]
rank_2014 <- rank[College_ranking$year == "2014",]
rank_2014 <- rank_2014[1:100,]
rank_2015 <- rank[College_ranking$year == "2015",]
rank_2015 <- rank_2015[1:100,]


