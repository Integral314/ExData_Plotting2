## Course Project 2 Plot 6

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
NEI.onroad <- subset(NEI, type=="ON-ROAD")
NEI.balt <- subset(NEI.onroad, fips == "24510", names(NEI))
NEI.LA <- subset(NEI.onroad, fips == "06037", names(NEI))
final.balt <- aggregate(NEI.balt$Emissions, list(NEI.balt$year), sum)
final.LA <- aggregate(NEI.LA$Emissions, list(NEI.LA$year), sum)
final <- data.frame(final.balt, final.LA$x)
names(final) <- c("Year", "Baltimore", "Los Angeles")
## Open Device
png(filename = "plot6.png", width = 480, height = 480)

## Create Plot
plot(final.balt$Group.1, final.balt$x, type = "b", xlab = "Year", ylab = "Total", 
     main = "Motor Vehicle Emsissions in Baltimore and LA 1999-2008", col = "blue" )
par(new = T, xpd = TRUE)
plot(final.LA$Group.1, final.LA$x, type = "b", col = "red", axes = FALSE, xlab = "", ylab = "")
legend("topright", legend = c("Baltimore", "LA"), fill = c("blue", "red"))

## Close device
dev.off()
