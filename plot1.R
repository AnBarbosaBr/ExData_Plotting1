unzip("exdata_data_household_power_consumption.zip")
dataset = readr::read_delim("household_power_consumption.txt", delim=";",
                            col_types = readr::cols(
                              .default = readr::col_guess(),
                              Date = readr::col_date(format="%d/%m/%Y"),
                              Time = readr::col_time()),
                            na = "?"
                            )


wanted <- as.Date(c('01/02/2007', '02/02/2007'), format = "%d/%m/%Y")
dataset <- subset(dataset, Date %in% wanted)

png("plot1.png")
with(dataset, {
    hist(Global_active_power, c="red", main="Global Active Power")
    axis(side = 2, at = seq(0,1200, 200))
})
dev.off()
