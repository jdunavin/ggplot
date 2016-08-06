### Chapter 4 - Mastering the Grammar
# Simple example
library(ggplot2)
ggplot(mpg, aes(displ, hwy, color=factor(cyl))) + geom_point()

# Add some complexity
ggplot(mpg, aes(displ, hwy)) + geom_point() +
  geom_smooth() + facet_wrap("year")