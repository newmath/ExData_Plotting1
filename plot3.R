dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")
rowsToRead <- as.numeric(dtime)
DT <- fread("household_power_consumption.txt", skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", ""))

colnames(DT) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

DT$Sub_metering_1 <- as.numeric(DT$Sub_metering_1)
DT$Sub_metering_2 <- as.numeric(DT$Sub_metering_2)
DT$Sub_metering_3 <- as.numeric(DT$Sub_metering_3)

X <- paste(DT$Date,DT$Time,sep=" ")
x <- strptime(X, format="%d/%m/%Y %H:%M:%S")

y1 <- DT$Sub_metering_1
y2 <- DT$Sub_metering_2
y3 <- DT$Sub_metering_3

xmin <- min(x)
xmax <- max(x)
ymin <- min(rbind(y1,y2,y3))
ymax <- max(rbind(y1,y2,y3))

plot(x,y1,type="l",ylab="Energy Sub Metering",xlab="",ylim=c(ymin,ymax))
par(new=T)
plot(x,y2,type="l",ylab="",xlab="",ylim=c(ymin,ymax),axes=F,col="red")
par(new=T)
plot(x,y3,type="l",ylab="",xlab="",ylim=c(ymin,ymax),axes=F,col="blue")

legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,col=c('black','red','blue'))

dev.copy(png,"plot3.png")
dev.off()
