## Plot 1 - display the household global minute-averaged active power (in kilowatt)
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

## convert to datetime
hpcdt <- paste(subhpc$Date, subhpc$Time)
subhpc$dateNtime <- as.POSIXct(strptime(hpcdt, "%d/%m/%Y  %H:%M:%S"))

## Plot in PNG
png(filename = file.path(path, "plot2.png"), width=480, height=480)
par(mar=c(4, 4, 4, 4) + 0.5)
plot(subhpc$Global_active_power~subhpc$dateNtime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(1, at=as.Date(c('2007-02-01', '2007-02-02', '2007-02-03')),lab=c("Thu","Fri","Sat"))

## shut down the PNG device
dev.off()