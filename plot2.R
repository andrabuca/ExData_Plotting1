plot2 <- function() {
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
  png(filename="plot2.png", width=480, height=480, units="px")
  
  # Manipulate the x-axis to fit the requirements
  smaller_mar <- par()[["mar"]] - c(1, 0, 0, 0)
  par(mar=smaller_mar)
  
  # Generating a time series plot with lines, including just the required two days
  dates <- seq.Date(from=as.Date("2007/02/01"), length.out=2, by="day")
  with(subset(d, subset=Date %in% dates),
       plot(Time, Global_active_power, type="l", xlab=NA,
            ylab="Global Active Power (kilowatts)"))
  
  # Save the file
  dev.off()
}