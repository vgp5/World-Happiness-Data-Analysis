happiness_data <- read.csv("WHR2023.csv")

library(ggplot2)
library(corrplot)

# Visualize the distribution of the happiness score using a histogram
ggplot(happiness_data, aes(x = `Ladderscore`)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Happiness Score",
       x = "Happiness Score",
       y = "Frequency")
ggsave("histogram.png", plot = last_plot(), width = 8, height = 6, dpi = 300)



# Example: Happiness score vs. Logged GDP per capita

ggplot(happiness_data, aes(x = `Logged.GDP.per.capita`, y = `Ladderscore`)) +
  geom_point(color = "blue") +
  labs(title = "Happiness Score vs. Logged GDP per Capita",
       x = "Logged GDP per Capita",
       y = "Happiness Score")



correlation_matrix <- cor(happiness_data[, c("Ladderscore", "Logged.GDP.per.capita", "Social.support", "Healthy.life.expectancy", "Freedom.to.make.life.choices", "Generosity", "Perceptions.of.corruption")])
# Generate correlation plot with adjusted text size
corrplot(correlation_matrix, method = "circle", type = "upper", tl.cex = 0.7)

plot.new()
dev.off()

ggsave("LadderVsLoggedGDPperCapita.png", plot = last_plot(), width = 8, height = 6, dpi = 300)



