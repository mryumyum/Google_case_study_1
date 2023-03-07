library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(tibble)

# Merge all data sets into one
csv_files <- list.files(path = getwd(), recursive = TRUE, full.names=TRUE)
df <- do.call(rbind, lapply(csv_files, read.csv))

# R imported the datetime columns as strings, so we have to convert them to datetime
df <- add_column(df, started_at_conv = as.POSIXct(df$started_at, format="%Y-%m-%d %H:%M:%S", tz="UTC"), .after = "ended_at")
df <- add_column(df, ended_at_conv = as.POSIXct(df$ended_at, format="%Y-%m-%d %H:%M:%S", tz="UTC"), .after = "started_at_conv")

# Calsulate triptime of each entry
df <- add_column(df, trip_length = round(difftime(df$ended_at_conv, df$started_at_conv, units="mins"), digits = 2), .after = "ended_at_conv")

# Create columns for individual month and weekday
df <- add_column(df, date = as.Date(substring(df$started_at, 1, 10)), .after = "ended_at")
df <- add_column(df, month = month(df$date, label =TRUE), .after = "date")
df <- add_column(df, weekday = weekdays(as.Date(df$date, format = "%m/%d/%Y")), .after = "month")

summary(df$trip_length)

# Some entries have negative ride times, since they're <200 wee will just delete them
df <- subset(df, trip_length > 0)

# One of the entries has a trip length of over 28 days
# I am making an assumption here about the data in saying that i would be very unpleasant to ride for over 24 straight hours
# There is also another story to be told about the cases that are over 24 hours are all docked bikes rented out by all casual members
sd(df$trip_length)
df <- subset(df, trip_length < 1500)

write.csv(df, "cleaned_merged_data.csv", row.names = FALSE)


