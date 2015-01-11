dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt", skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

colnames(DT) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

require(astsa)

DT$Global_active_power <- as.numeric(DT$Global_active_power)

X <- paste(DT$Date,DT$Time,sep=" ")
x <- strptime(X, format="%d/%m/%Y %H:%M:%S")
y <- DT$Global_active_power

plot(x,y,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.copy(png,"plot2.png")
dev.off()
