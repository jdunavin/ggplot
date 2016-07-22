## ggplot book, chapter 3

library(ggplot2)

# Purpose of the layers:
# 1. Display the data
# 2. Display statistical summary of data
# 3. Add additional metadata

# 3.2 Basic plot types 
# Examples
df <- data.frame(x=c(3,1,5), y=c(2,4,6), label=c("a","b","c"))
p <- ggplot(df, aes(x,y, label=label)) +
   labs(x=NULL, y=NULL) +
  theme(plot.title = element_text(size=12))
p + geom_point() + ggtitle("point") # Ex 3.1.1
p + geom_text() + ggtitle("text")
p + geom_bar(stat="identity") + ggtitle("bar") # Ex 3.1.4
p + geom_tile() + ggtitle("raster")
p + geom_line() + ggtitle("line") # Ex 3.1.2
p + geom_area() + ggtitle("area")
p + geom_path() + ggtitle("path")
p + geom_polygon() + ggtitle("polygon")

# 3.1.3 = geom_histogram
# 3.1.5 = geom_bar with the polar attribute

# Ex 3.2
# Polygon fills in the last side of the path and then 
# the space inbetween, path is a directed line around 
# the edge
# path and line are different because path is directed
# in the order data appears

# Ex 3.3
# smooth = line
# boxplot = point?
# violin = point?

# 3.3 - LABELS

# Font
df <- data.frame(x=1, y=3:1, family=c("sans","serif","mono"))
ggplot(df, aes(x,y)) +
  geom_text(aes(label=family, family=family))

# Face
df <- data.frame(x=1, y=3:1, face=c("plain","bold","italic"))
ggplot(df, aes(x,y)) +
  geom_text(aes(label=face, fontface=face))

# Position
df <- data.frame(x=c(1,1,2,2,1.5),y=c(1,2,1,2,1.5), text=c("bottom-left","bottom-right","top-left","top-right","center"))
# centered on the point
ggplot(df, aes(x,y)) + geom_text(aes(label=text))
# directed toward center of plot
ggplot(df, aes(x,y)) + geom_text(aes(label=text), vjust="inward", hjust="inward")

# size (in mm) and angle (in degrees) too

# label existing points
df <-data.frame(trt=c("a","b","C"), resp=c(1.2,3.4,2.5))
ggplot(df, aes(resp, trt)) +
  geom_point() + 
  geom_text(aes(label=paste0("(",resp,")")), nudge_y=-0.25) + xlim(1,3.6)

# What to do with overlapping points
ggplot(mpg, aes(displ, hwy)) +
  geom_text(aes(label=model)) +
  xlim(1,8)
ggplot(mpg, aes(displ, hwy)) +
  geom_text(aes(label=model), check_overlap = TRUE) +
  xlim(1,8)

# another type of label with a background
label <- data.frame(waiting=c(55,80), eruptions=c(2,4.3), label=c("peak one", "peak two"))
ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_tile(aes(fill=density)) +
  geom_label(data=label, aes(label=label))