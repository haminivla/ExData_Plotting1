plot3 <- function() {

	## Read in first 5 rows to get the column classes
	cols <- read.table("household_power_consumption.txt", sep=";", header=T, nrows=5, stringsAsFactors=F)
	classes <- sapply(cols, class)

	## Reading the table with column classes specified speeds up the process
	dat <- read.table("household_power_consumption.txt", sep=";", colClasses=classes, na.strings="?", header=T)

	## Subset data frame based on the required dates and paste date/time columns into a single DateTime column
	subst <- dat[dat$Date %in% c("1/2/2007", "2/2/2007"),]
	subst["DateTime"] <- paste(subst$Date, subst$Time)

	## Covert the DateTime column into POSIXlt format and remove the redundant Date/Time columns
	subst$DateTime <- strptime(subst$DateTime, "%d/%m/%Y %H:%M:%S")
	subst$Date <- subst$Time <- NULL
	
	## Draw the graph with specified parameters
	with(subst, {
		plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
		points(DateTime, Sub_metering_2, type="l", col="red")
		points(DateTime, Sub_metering_3, type="l", col="blue")
		points(DateTime, Sub_metering_3, type="l", col="blue")
	})
	legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

	## Output screen to PNG file. Since default size is 480x480, we need not specify them.
	dev.copy(png, file="plot3.png")
	dev.off()
}