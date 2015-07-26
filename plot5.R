## Course Project 2 Plot 5

## Create Download url
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

## Download and extract data
download.file(url, destfile = "data.zip")
unzip("data.zip")

## read data in to working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Build dataframe
library(dplyr)
NEI.balt <- subset(NEI, fips == "24510", names(NEI))
mv <- subset(NEI.balt, type=="ON-ROAD")
final <- aggregate(NEI.balt$Emissions, list(NEI.balt$year), sum)

## Open Device
png(filename = "plot5.png", width = 480, height = 480)

## Create Plot
plot(final$Group.1, final$x, type = "b", xlab = "Year", ylab = "Total", main = "Motor Vehicle Emsissions in Baltimore 1999-2008")
text(final$Group.1[1:2], final$x[1:2], labels = l[1:2], pos = 1, cex = .7)
text(final$Group.1[3], final$x[3], labels = l[3], pos = 4, cex = .7)
text(final$Group.1[4], final$x[4], labels = l[4], pos = 2, cex = .7)

## Close device
dev.off()