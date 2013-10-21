# Homework #6: Linking scripts PART I

# Load in the data and any libraries I need. The data is already in a fairly clean csv format, but I would rather not deal with factors so I am importing everything as character or numeric.


library(ggplot2)
nhl <- read.csv("NHLplayerstats.csv", stringsAsFactors=F)


# Lets take a look at the data to see if it imported correctly:


head(nhl)
tail(nhl)
summary(nhl)


# First thing is that TOI, or Time On Ice is in a weird format, Minute:Second:???. This is not conductive to our analyses so lets convert it to minutes with a decimal value for seconds.


nhl$TOI <- as.numeric(lapply(strsplit(nhl$TOI, ":"), "[", 1)) + as.numeric((lapply(strsplit(nhl$TOI, ":"), "[", 2)))/60
summary(nhl)


# That worked well. The rest of the data columns are numeric. 

# The next step is to do some basic data visualization to see if there are any problems.


pdf("Pt1.PointsByTime.pdf")
plot1 <-ggplot(nhl, aes(x = TOI, y = Points)) +
  geom_point(aes(color=as.character(Year), shape=Position))
print(plot1)
dev.off()
pdf("Pt1.ShotpercntByGoals.pdf")
plot2 <- ggplot(nhl, aes(y=G60, x = ShPct)) +
  geom_point()
print(plot2)
dev.off()


# This data visualization checked out. The first showed that more time on the ice resulted in more points, and that the slope of this relationship differed between defensemen and forwards. Also in 2012 the season was shortened so the max time on the ice was lower. 

# The second plot showed that shot accuracy resulted in increased goals, a rather intuitive observation.

# For the second analysis we want to focus just on the Canucks, and sort the data by player name. We then want to write that out to a machine readable format.

Canucks <- nhl[ which(nhl$Team=='Vancouver'), ]
Canucks <- Canucks[ order(Canucks[,1]),]
head(Canucks)
write.csv(Canucks, file="Canucks.csv", row.names=F)

