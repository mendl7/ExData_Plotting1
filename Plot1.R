# Read Raw Data
rawdata<-read.table("household_power_consumption.txt", na.strings=c("?"), header=T, sep=";")

# Format Data
# We will only be using data from the dates 2007-02-01 and 2007-02-02
data<-rawdata[as.Date(rawdata$Date, format="%d/%m/%Y") %in% as.Date(c('2007-02-01', '2007-02-02')),]

# Convert factors to numerics. Can't go directly due to known factor->numeric issue
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))

# Plot 1
par(mfrow=c(1,1))
hist(data$Global_active_power, freq=T, col="red", 
     xlab=c("Global Active Power (kilowatts)"), main=c("Global Active Power"))
dev.copy(png, file="Plot1.png", height=480, width=480, units="px")
dev.off()
