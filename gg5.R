### Chapter 5 - Build a Plot Layer by Layer
library(ggplot2)
library(dplyr)
# Step 1 - plot with default dataset and aesthetic mappings
p <- ggplot(mpg, aes(displ, hwy))
p
p + geom_point()
# mapping - inherits mapping from ggplot
# data - inherits dataset from ggplot
# geom - points
# stat - name of statistical transformation, identity = leave it alone
# position - how to deal with overlapping objects, identity = don't

# example with multiple data layers
mod <- loess(hwy~displ, data=mpg)
grid <-data.frame(displ=seq(min(mpg$displ),max(mpg$displ),length=50))
grid$hwy <- predict(mod, newdata=grid)
grid
std_resid <- resid(mod) / mod$s
outlier <- filter(mpg, abs(std_resid)>2)
head(outlier,10)
outlier

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_line(data=grid, color="blue", size=1.5) +
  geom_text(data=outlier, aes(label=model))

# Exercise 5311 First two arguments are data and mapping in ggplot, and
# then mapping and data in all layer functions. Why?
# Typically you set what two variables will be related for one graph and
# then don't change it. You can change what data is laid on them.

# Exercise 5312
class <- mpg %>% group_by(class) %>% summarize(n=n(), hwy=mean(hwy))

# Recreate the graph in the book - This oughta do it
p + 
  geom_jitter(data=mpg, aes(class, hwy), width=0.2) +
  geom_point(color="magenta", size=4) +
  geom_text(aes(y=10, label=paste0("n=",n)), size=3, data=class)
