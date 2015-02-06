
data_full <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

rm(data_full)

dev.off() # resseting par, as I am using transparent background and charts would overlap otherwise in RStudio
par(mfrow = c(2,2), bg="transparent")
par(mar=c(4, 4, 0.5, 0.5))

plot(x=data$Datetime, y=data$Global_active_power, main = "", ylab="Global Active Power (kilowatts)", xlab="", type="l")

with(data, plot(x=Datetime, y=Voltage, main = "", type="l"))

plot(x=data$Datetime, y=data$Sub_metering_1, main = "", ylab="Energy sub metering", xlab="", type="n")
lines(x=data$Datetime, y=data$Sub_metering_1, col="black")
lines(x=data$Datetime, y=data$Sub_metering_2, col="red")
lines(x=data$Datetime, y=data$Sub_metering_3, col="blue")
legend("topright", lty=1, lwd=2, bty = "n", col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data, plot(x=Datetime, y=Global_reactive_power, main = "", type="l"))



## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()