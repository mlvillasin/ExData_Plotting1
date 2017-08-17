## Plot 1 
## x-axis will be the Global Active Power
## y-axis will be the frequency

## library to use for reading data
library(data.table)

## download and read data
path <- getwd() 
z <- tempfile()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, z)
unzip(z, exdir=path)
dfhpc <- fread(file.path(path, "household_power_consumption.txt"), na.strings = "?")
subhpc <- subset(dfhpc, as.Date(Date,"%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02")

## Plot in PNG
png(filename = file.path(path, "plot1.png"), width=480, height=480)
hist(subhpc$Global_active_power, main = "Global Active Power", xlab ="Global Active Power (kilowatts)", ylab="Frequency", col="red")

## shut down the PNG device
dev.off()