# First, load the tidyverse package which contains ggplot2, readr, and dplyr, which we'll use
library(tidyverse)

# The key decision/challenge here is how to set up your data. ggplot2 really wants you to set your data up in a specific manner, and the reward for doing so is that plotting becomes like running downhill.

# To keep this file self-contained, I'll use read_csv to create a fake dataset. 
df <- read_csv(
  "predictor, response, odds, CIHigh, CILow
  Predictor A, response 1, 2.23, 0.70, 6.60
  Predictor A, response 2, 1.32, 1.02, 1.70
  Predictor A, response 3, 1.23, 0.97, 1.56
  Predictor B, response 1, 0.82, 0.65, 1.04
  Predictor B, response 2, 0.98, 0.96, 1.00
  Predictor B, response 3, 0.98, 0.86, 1.11
  Predictor C, response 1, 0.66, 0.50, 0.87
  Predictor C, response 2, 0.59, 0.36, 0.98
  Predictor C, response 3, 0.98, 0.86, 1.11"
)

# Now there are 2 options. There is a ton of tweaking you can do to make each graph look pretty, but I'll leave that as an exercise for you.

# option 1: using facet_wrap to plot them next to each other

ggplot(df, aes(x = odds, y = predictor)) +
  geom_vline(aes(xintercept = 1), size = .25, linetype = "dashed") +
  geom_errorbarh(aes(xmax = CIHigh, xmin = CILow), size = .5, height = .1, color = "gray50") +
  geom_point(size = 4, color = "blue") +
  facet_wrap(~response) +
  scale_x_continuous(breaks = seq(0,7,1) ) +
  coord_trans(x = "log10") +
  theme_bw() +
  theme(panel.grid.minor = element_blank())

# option 2: plotting them all on one graph. This requires a using filter to plot one set of points and CIs at a time and manually adjusting their height using an adjustment variable and position_nudge()

adj = .2 # This is used in position_nudge to move the dots

ggplot(df, aes(x = odds, y = predictor, color = response)) +
  geom_vline(aes(xintercept = 1), size = .25, linetype = "dashed") +
  geom_errorbarh(data = filter(df, response== "response 1"), aes(xmax = CIHigh, xmin = CILow), size = .5, height = .1, color = "gray50", position = position_nudge(y = adj)) +
  geom_point(data = filter(df, response== "response 1"), size = 4, position = position_nudge(y = adj)) +
  geom_errorbarh(data = filter(df, response== "response 2"), aes(xmax = CIHigh, xmin = CILow), size = .5, height = .1, color = "gray50") +
  geom_point(data = filter(df, response== "response 2"), size = 4) +
  geom_errorbarh(data = filter(df, response== "response 3"), aes(xmax = CIHigh, xmin = CILow), size = .5, height = .1, color = "gray50", position = position_nudge(y = - adj)) +
  geom_point(data = filter(df, response== "response 3"), size = 4, position = position_nudge(y = - adj)) +
  scale_x_continuous(breaks = seq(0,7,1) ) +
  coord_trans(x = "log10") +
  theme_bw() +
  theme(panel.grid.minor = element_blank())
