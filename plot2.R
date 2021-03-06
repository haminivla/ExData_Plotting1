plot2 <- function() {

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
	
	## Draw the graph with specified parameters and copy the screen output into a PNG file
	plot(subst$DateTime, subst$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
	
	## Output screen to PNG file. Since default size is 480x480, we need not specify them.
	dev.copy(png, file="plot2.png")
	dev.off()
}