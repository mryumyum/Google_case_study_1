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

#write.csv(df, "cleaned_merged_data.csv", row.names = FALSE)

df <- read.csv("cleaned_merged_data.csv")

summary()





