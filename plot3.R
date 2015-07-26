## Course Project 2 Plot 3

## Create Download url
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

## Download and extract data
download.file(url, destfile = "data.zip")
unzip("data.zip")

## read data in to working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset for Baltimore data
NEI.balt <- subset(NEI, fips == "24510", names(NEI))

## Arrange Dataframe
library(dplyr)
df <- summarise(group_by(NEI.balt, year, type), sum(Emissions))
names(df) <- c("Year", "type", "Emissions")
df$Year <- as.character(df$Year)

## Open device to create histogram
png(filename = "plot3.png", width = 480, height = 480)

## Create Plot
library(ggplot2)
qplot(Year, Emissions, data = df, facets = .~type) + labs(title = "Total Emissions per Year by Source") + scale_x_discrete(breaks = c("1999", "2002", "2005", "2008"))

## Close device
dev.off()