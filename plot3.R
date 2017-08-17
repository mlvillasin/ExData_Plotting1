## Plot 3
## x-axis will be Days
## y-axis will be the Energy Sub Metering

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

## convert to datetime
hpcdt <- paste(subhpc$Date, subhpc$Time)
subhpc$dateNtime <- as.POSIXct(strptime(hpcdt, "%d/%m/%Y  %H:%M:%S"))

## Plot in PNG
png(filename = file.path(path, "plot3.png"), width=480, height=480)
plot(subhpc$Sub_metering_1~subhpc$dateNtime, type = "l", ylab = "Energy sub metering", xlab = "" )
lines(subhpc$Sub_metering_2~subhpc$dateNtime, col = "red")
lines(subhpc$Sub_metering_3~subhpc$dateNtime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## shut down the PNG device
dev.off()