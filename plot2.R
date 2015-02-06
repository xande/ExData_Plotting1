
data_full <- read.csv(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=';', na.strings="?", 
                 nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

rm(data_full)

dev.off() # resseting par, as I am using transparent background and charts would overlap otherwise in RStudio
par(bg="transparent") # setting transparent BG

# Plotting active power consumption chart
plot(x=data$Datetime, y=data$Global_active_power, main = "", ylab="Global Active Power (kilowatts)", xlab="", type="l")

# Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()