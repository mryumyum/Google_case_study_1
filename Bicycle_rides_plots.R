library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(tibble)

df <- read.csv("cleaned_merged_data.csv")

ggplot(df, aes(fill=member_casual, x=weekday)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of Total Riders on Weekdays") +
  ylab("Total Num of riders") +
  theme(legend.title = element_blank())

ggplot(df, aes(fill=member_casual, y=trip_length, x=weekday)) + 
  stat_summary(fun = "mean", geom = "bar", position = "dodge") + 
  ggtitle("Average Trip Length On a Given Weekday") +
  ylab("Average Trip Length") +
  theme(legend.title = element_blank())

ggplot(df, aes(fill=member_casual, x=rideable_type)) + 
  geom_bar(position = "dodge") + 
  ggtitle("Types of Bikes Riders Prefer") +
  ylab("Total Num of riders") +
  theme(legend.title = element_blank())

ggplot(df, aes(fill=member_casual, y=trip_length, x=rideable_type)) + 
  stat_summary(fun = "mean", geom = "bar", position = "dodge") + 
  ggtitle("Average Trip Length Based on Bike Type") +
  ylab("Average Trip Length") +
  theme(legend.title = element_blank())
