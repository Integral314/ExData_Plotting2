## Course Project 2 Plot 1

## Create Download url
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

## Download and extract data
download.file(url, destfile = "data.zip")
unzip("data.zip")

## read data in to working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Sum Emissions by year
Yr.sums <- rowsum(NEI$Emissions, NEI$year)
years <- c("1999", "2002", "2005", "2008")
names(Yr.sums) <- years

## Create Lable vector
l <- as.character(round(Yr.sums))

## Open device to create histogram
png(filename = "plot1.png", width = 480, height = 480)

## Create plot
plot(Yr.sums ~ names(Yr.sums), col = "blue", xlab = "Year", ylab = "Totals", main = "Total PM25 Emissions", xaxt = "n", yaxt = "n")
axis(1, at = years, labels = years)
text(Yr.sums[1] ~ names(Yr.sums)[1], labels = l[2:3], pos = 4, cex = .7)
text(Yr.sums[2:3] ~ names(Yr.sums)[2:3], labels = l[2:3], pos = 1, cex = .7)
text(Yr.sums[4] ~ names(Yr.sums)[4], labels = l[4], pos = 2, cex = .7)

## Close device
dev.off()