library(curl)
library(jsonlite)
library(showtext)
library(tidyr)
library(dplyr)
library(readxl)
library(ggplot2)
library(readr)

# Load data
df_trump <- read_excel("data_trump.xlsx", sheet = 1)
df_harris <- read_excel("data_harris.xlsx", sheet = 1)

# Label data source
df_trump$candidate <- "Trump"
df_harris$candidate <- "Harris"

# Variables to plot
vars_to_plot <- c("type", "freq")

# Subset data
df_trump_sel <- df_trump[, vars_to_plot]
df_trump_sel$candidate <- "Trump"

df_harris_sel <- df_harris[, vars_to_plot]
df_harris_sel$candidate <- "Harris"

# Words to keep
common_words <- c("i", "we", "will", "america", "fight", "win", "together")

# Filter for common words
df_trump_filtered <- df_trump_sel %>% filter(type %in% common_words)
df_harris_filtered <- df_harris_sel %>% filter(type %in% common_words)

# Combine datasets
df_combined <- bind_rows(df_trump_filtered, df_harris_filtered)

# Plot grouped bar chart
font_add_google("Bai Jamjuree", "bai jamjuree")
showtext_auto()

ggplot(df_combined, aes(x = type, y = freq, fill = candidate)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.7), width = 0.6) +
  scale_fill_manual(values = c("Trump" = "burlywood1", "Harris" = "chocolate1")) +
  labs(
    title = "type frequency by candidate",
    subtitle = "selected common words from x.com posts",
    x = "type",
    y = "frequency",
    fill = "candidate"
  ) +
  theme_light(base_family = "bai jamjuree", base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", size = 18, hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
    axis.text.y = element_text(size = 12),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank()
  )



