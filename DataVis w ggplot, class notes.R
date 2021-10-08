# Data Vis tutorial KORS
# Rick Scavetta 
# 08 Oct 2020
# Some coding exercises for data viz

# Using Color ----

## 4 dimensions of color ----

# These dimensions converge at one end making them unsuitable
# for an "encoding element" (see book), aka a "mapping aesthetic" in ggplot2
# 1. Saturation - Purity [grey - pure] - colors converge on grey at low saturation 
# 2. Alpha - opacity [transparent - opaque] - colors converge on transparent at low alpha

# These work well
# Hue - The actual "color" - ROY G BIV
# Lightness - [pure black (shades) - pure white (tints)]
# Colors converge on black and white at the extreme ends of lightness, but there is a lot of room to work with still

## Typical variable types ----

# cont - Continuous data
# cat - Ordinal (numerical) "levels" are ordered (low, med, high) (4, 6, 8)
# cat - Nominal - no logical order (WT, trt1, trt2)

## Color Brewer ----

# 3 Standard color palette types and the variable types they represent
# qual = Nominal (not suitable for cont, think rainbows)
# seq = Ordinal (e.g. low - med - high dose <=> light - med - dark blue)
# seq = Continuous
# div = Use coloe to represent 2 variables: Nominal & Ordinal
#     = qual (e.g. Red and Blue) for Nominal variables (treatment vs control)
#     = seq (light - dark) for Ordinal variables (low & high dose)
# e.g. see the peppermint example:
#      water: drought or normal <=> Ordinal: lightness, seq palette 
#      sugar: Glu, Fru, Suc <=> Nominal: hue, qual palette (purple, green, blue)

## Hex codes ----

# use the Hex codes:
# base 16 Hexadecimal colors (0-9 A-F)
# RRGGBB 
# 256 possible 2-digit "numbers" 00 -FF, 16ˆ2
256*256*256 # 16.8 million colors


# ggplot2 ----

library(ggplot2)

# Reproduce the example shown in class

## The data ----
iris

## Example ----

# Some functions from class
ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point(shape = 16, alpha = 0.5, position = posn_j) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous("name") +
  scale_color_brewer("Species", palette = "Dark2") +
  NULL

# Notes ----

## Position ----
# 3 ways to use a position
# 1. Most basic
geom_point(positon = "jitter")

# 2. Call geom_jitter(), a convenience function
geom_jitter() #use it like geom_point

# 3. Use Position functions to access all arguments
# save to an object to make reproducible
posn_d <- position_dodge(width = 0.3)
posn_j <- position_jitter(width = 0.3)
posn_jd <- position_jitterdodge(jitter.width = 0.3, dodge.width = 0.3)

# Use positon objects to ensure that different geoms of a single plot are aligned:
# geom_errorbar(position = posn_d)
# geom_line(position = posn_d)

## Using manual colors ----

# Defining colors in a named vector
myColors <- c("setosa" = "#1B9E77", # green
              "versicolor" = "#7570B3", # purple
              "virginica" = "#D95F02") # orange

# A named vector ensures that each level in a factor variable will 
# ALWAYS get the same color. In a plot implement using:
# scale_color_manual("Species", values = myColors) +

# Check hex codes visually
# munsell::plot_hex(myColors)

## Overplotting issues ----

# How to deal with over-plotting? 
# "over-plotting" = See point in univariate distibutions
# opaque & overlapping points obscure the data's actual distribution. 

# When does over-plotting occur:
# 1 - low-precision data (here to one decimal place)
# 2 - all data points aligns on an axis (cont y ~ cat x)
# 3 - cat y ~ cat x (cat = nom, ord, integer) 
# 4 - a large amount of data (e.g. scatter plot with lots of values)

## Overplotting integer y ~ x example ----
library(car) # The package to accompany the "Companion to applied regression in R" book
str(Vocab)

# vocabulary ~ education, y ~ x
# ggplot creates an aes mapping 
p <- ggplot(Vocab, aes(education, vocabulary)) +

# extreme overplotting of over 30000 ovservations
p +
  geom_point()

# one solution: use stat_sum() to add up all overlapping observations 
# this maps n onto the size aesthetic, specifically, it's the area
# modify the size aesthetic using scale_size_area()
p +
  stat_sum() +
  scale_size_area(max_size = 30)

# Remember, geoms stats and position are all available as functions and arguments
# Some geoms will apply a statistic that create a new variable and then 
# automatically map it onto an aesthetic:
# e.g. 
# geom_density() => stat: density => aes: map density onto y
# geom_histogram() => stat: bin and count obs in each bin => aes: map count or proportion onto y
# geom_bar() => stat: count => aes: map count onto y

## Overplotting olutions ----

# *alpha* = set as an attribute in the geom layer
# *position* = i.e. "jitter" = Adding a small amount of random, Normally-distibuted noise to the x and/or y axis
# *shape* = set to 1 for hollow circles
# *size* = map n count onto size

# AESTHETIC v ATTRIBUTE ----

# Recall:
# AESTHETIC = MAPPING a variable onto a scale (aesthetic, axis)
# color, fill, linetype, alpha, size

# ATTRIBUTE = SETTING the properties of how a geom looks
# color, fill, linetype, alpha, size

