
dataset = readr::read_delim("household_power_consumption.txt", delim=";",
                            col_types = readr::cols(
                              .default = readr::col_guess(),
                              Date = readr::col_date(format="%d/%m/%Y"),
                              Time = readr::col_time()),
                            na = "?"
)


wanted <- as.Date(c('01/02/2007', '02/02/2007'), format = "%d/%m/%Y")
dataset <- subset(dataset, Date %in% wanted)

dataset2 <- dplyr::mutate(dataset, DateTime = as.POSIXct(paste(Date,Time)))


png("plot4.png")
with(dataset2, {
  par(mfrow=c(2,2))
  plot(Global_active_power ~ DateTime, type="l")
  plot(Voltage ~ DateTime, type="l")
  plot(Sub_metering_1 ~ DateTime, type="l",  col="black")
  lines(Sub_metering_2 ~ DateTime, type="l", col="red")
  lines(Sub_metering_3 ~ DateTime, type="l", col="blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         text.col = c("black","red","blue"), cex = 0.5)
  plot(Global_reactive_power ~ DateTime, type="l")
  
}
)
dev.off()
