# Read Raw Data
rawdata<-read.table("household_power_consumption.txt", na.strings=c("?"), header=T, sep=";")

# Format Data
# We will only be using data from the dates 2007-02-01 and 2007-02-02
data<-rawdata[as.Date(rawdata$Date, format="%d/%m/%Y") %in% as.Date(c('2007-02-01', '2007-02-02')),]
# Generate datatime column
data$datetime<-strptime(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "), 
                        format="%Y-%m-%d %H:%M:%S")
# Convert factors to numerics. Can't go directly due to known factor->numeric issue
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3<-as.numeric(as.character(data$Sub_metering_3))

# Plot 3 
png(file="Plot3.png", width=480, height=480, units="px")
par(mfrow=c(1,1))
plot(data$datetime, data$Sub_metering_1, xaxt = "n", type="l", col="black", 
     ylab="Energy sub metering", xlab="")
axis.POSIXct(1, data$datetime, format="%a")
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), lwd=c(2,2,2), col=c("black", "red", "blue"))
dev.off()