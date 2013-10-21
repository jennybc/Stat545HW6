# Homework #6: Linking scripts PART II

# Firstly load in packages.

library(plyr)
library(ggplot2)


# Next we bring in the canucks csv file made in the previous analysis.

Canucks <- read.csv("Canucks.csv", stringsAsFactors=F)
head(Canucks)
summary(Canucks)


# Now we analyze the Canucks. My main purpose is to see the trend of how Canucks players have improved or worsened over the six years of play for which I have data. For further that end, lets see individual shot percentage over time.
pdf("Pt2.GoalsByYear.pdf")
plot3 <- ggplot(Canucks, aes(x=Year, y=G60)) +
  geom_line(aes(group=PlayerName, color=Position)) +
  geom_point(aes(group=PlayerName, color=Position)) +
  geom_errorbar(stat = "hline", yintercept = "mean",
  width=0.8,aes(ymax=..y..,ymin=..y.., group=Year))
print(plot3)
dev.off()

# This plot isn't too informative because of the stochastic variation in player output year by year, particularly in the forwards. Additionally, there is a large turnover in players between years making it difficult to infer patterns.


stats <-  ddply(Canucks, .(PlayerName), summarize,
                  mean_TOI=mean(TOI, na.rm=T),
                  mean_G60=mean(G60, na.rm=T))
seasons <-count(Canucks$PlayerName)
colnames(seasons) <- c("PlayerName","SeasonsPlayed")
total_stats <- merge(stats, seasons, by = "PlayerName")
pdf("Pt2.SeasonsPlayedByTime.pdf")
plot4 <- ggplot(total_stats, aes(x=mean_TOI, y=SeasonsPlayed)) +
         geom_point()
print(plot4)
dev.off()
# From this we can see a general trend that the players who stuck around with the Canucks for all or most of the recorded seasons played a large amount. For those players who were only with the canucks for one or two seasons, their average play time varied highly, as they include players who are just getting started with the Canucks and those that got traded after only one or two seasons. 
