happiness_data <- read.csv("WHR2023.csv")
missing_values <- sum(is.na(happiness_data))
cat("Missing values count:", missing_values, "\n")



str(happiness_data)

head(happiness_data)


summary(happiness_data)

summary_output <- capture.output(summary(happiness_data))

writeLines(summary_output, "summary_output.txt")