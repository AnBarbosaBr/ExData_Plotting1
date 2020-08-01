
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


png("plot2.png")
with(dataset2, {
  plot(Global_active_power ~ DateTime, type="l")
})
dev.off()
