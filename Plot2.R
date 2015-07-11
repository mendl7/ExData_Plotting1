# Read Raw Data
rawdata<-read.table("household_power_consumption.txt", na.strings=c("?"), header=T, sep=";")

# Format Data
# We will only be using data from the dates 2007-02-01 and 2007-02-02
data<-rawdata[as.Date(rawdata$Date, format="%d/%m/%Y") %in% as.Date(c('2007-02-01', '2007-02-02')),]
# Generate datatime column
data$datetime<-strptime(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "), 
                        format="%Y-%m-%d %H:%M:%S")
# Convert factors to numerics. Can't go directly due to known factor->numeric issue
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))

# Plot 2
par(mfrow=c(1,1))
plot(data$datetime, data$Global_active_power, xaxt = "n", type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
axis.POSIXct(1, data$datetime, format="%a")
dev.copy(png, file="Plot2.png", height=480, width=480, units="px")
dev.off()
