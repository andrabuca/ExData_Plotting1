plot3 <- function() {
  
  filename <- "household_power_consumption.txt"
   
  # Read data
  d <- read.table(file=filename, header=T, sep=";", na.strings="?",
                  comment.char="", nrows=2100000,
                  colClasses=c("character", "character", "numeric", "numeric", "numeric",
                               "numeric", "numeric", "numeric", "numeric"))
  
  # Convert Date and Time columns
  d$Time <- strptime(paste(d$Date, d$Time, sep=" "),
                     format="%d/%m/%Y %T", tz="GMT")
  d$Date <- as.Date(d$Date, format="%d/%m/%Y")
  
  #  Create plot framework
  png(filename="plot3.png", width=480, height=480, units="px")
  
  # Manipulate the x-axis to fit the requirements
  smaller_mar <- par()[["mar"]] - c(1, 0, 0, 0)
  par(mar=smaller_mar)
  
  # Include just the required two days
  dates <- seq.Date(from=as.Date("2007/02/01"), length.out=2, by="day")
  
  # Overlay 3 plots
  attach(subset(d, subset=Date %in% dates))
  plot(Time, Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1, col=c("black", "red", "blue"), cex=0.95)
  detach()
  
  # Save the file
  dev.off()
}