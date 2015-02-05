plot1 <- function() {

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
	
	## Draw the histogram with specified parameters and copy the screen output into a PNG file
	hist(subst$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
	dev.copy(png, file="plot1.png")
	dev.off()
}