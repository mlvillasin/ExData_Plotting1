## Plot 4
## Different varieties

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

# Plot in PNG
png(filename = file.path(path, "plot4.png"), width=480, height=480)
par(mfrow = c(2,2))
plot(subhpc$Global_active_power~subhpc$dateNtime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
plot(subhpc$Voltage~subhpc$dateNtime, type = "l", xlab = "datetime", ylab = "Voltage")
plot(subhpc$Sub_metering_1~subhpc$dateNtime, type = "l", ylab = "Energy sub metering", xlab = "" )
lines(subhpc$Sub_metering_2~subhpc$dateNtime, col = "red")
lines(subhpc$Sub_metering_3~subhpc$dateNtime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subhpc$Global_reactive_power~subhpc$dateNtime, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## shut down the PNG device
dev.off()
