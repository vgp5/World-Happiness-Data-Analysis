dev.off()
happiness_data <- read.csv("WHR2023.csv")

library(ggplot2)
library(corrplot)
 
# Perform multiple linear regression
lm_model <- lm(`Ladderscore` ~ `Logged.GDP.per.capita` + `Social.support` + `Healthy.life.expectancy` + `Freedom.to.make.life.choices` + `Generosity` + `Perceptions.of.corruption`, data = happiness_data)

# Summarize the regression results
summary(lm_model)

output <- capture.output(summary(lm_model))

# Get R-squared and adjusted R-squared
rsquared <- summary(lm_model)$r.squared
adj_rsquared <- summary(lm_model)$adj.r.squared

# Print R-squared and adjusted R-squared
cat("R-squared:", rsquared, "\n")
cat("Adjusted R-squared:", adj_rsquared, "\n")
output <- c(output, paste("R-squared:", rsquared), paste("Adjusted R-squared:", adj_rsquared))

writeLines(output, "regression_analysis_output.txt")


# Extract coefficients and confidence intervals
coefficients <- coef(lm_model)
conf_intervals <- confint(lm_model)

# Create a data frame for plotting
coefficients_df <- data.frame(variable = names(coefficients),
                              coefficient = coefficients,
                              lower_ci = conf_intervals[, 1],
                              upper_ci = conf_intervals[, 2])

library(pdp)
library(ggplot2)

# Adjust plot margins for coefficient plot
par(mar = c(5, 5, 2, 2), plt = c(0.1, 0.9, 0.1, 0.9))

# Create partial dependence plot for one variable (e.g., Logged GDP per capita)
partial_plot <- partial(lm_model, pred.var = "Logged.GDP.per.capita")

# Create coefficient plot
coefficients <- coef(lm_model)
conf_intervals <- confint(lm_model)
coefficients_df <- data.frame(variable = names(coefficients),
                              coefficient = coefficients,
                              lower_ci = conf_intervals[, 1],
                              upper_ci = conf_intervals[, 2])
coeff_plot <- ggplot(coefficients_df, aes(x = reorder(variable, coefficient), y = coefficient)) +
  geom_point(color = "blue") +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), width = 0.2, color = "blue") +
  coord_flip() +
  labs(title = "Coefficient Plot",
       x = "Independent Variable",
       y = "Estimated Coefficient") +
  theme_minimal()

# Save both plots as PNG files
png("coeff_plot.png", width = 800, height = 600)  # Open PNG device
print(coeff_plot)  # Print coefficient plot
dev.off()  # Close PNG device and save plot as "coeff_plot.png"

png("partial_plot.png", width = 800, height = 600)  # Open PNG device
print(plotPartial(partial_plot, 
                  main = "Partial Dependence Plot for Logged GDP per Capita",
                  xlab = "Logged GDP per Capita",
                  ylab = "Partial Dependence"))  # Print partial dependence plot
dev.off()  # Close PNG device and save plot as "partial_plot.png"
