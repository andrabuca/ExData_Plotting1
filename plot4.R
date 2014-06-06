plot4 <- function() {
 
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
  
  # Create plot framework
  png(filename="plot4.png", width=480, height=480, units="px")
  
  # Generate a 2x2 array for plots
  par(mfrow=c(2, 2))
  
  # Include just the required two days
  dates <- seq.Date(from=as.Date("2007/02/01"), length.out=2, by="day")
  
  attach(subset(d, subset=Date %in% dates))
  
  # Plot Global_active_power variable
  plot(Time, Global_active_power, type="l", xlab=NA, ylab="Global Active Power")
  
  # Plot Voltage variable
  plot(Time, Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # Multivariate plot of Sub_metering_1, Sub_metering_2, Sub_metering_3
  plot(Time, Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty="n", lty=1, col=c("black", "red", "blue"), cex=0.95)
  
  # Plot of Voltage variable
  plot(Time, Global_reactive_power, type="l", xlab="datetime",
       ylab="Global Reactive Power")
  
  detach()
  
  # Save the file
  dev.off()
}