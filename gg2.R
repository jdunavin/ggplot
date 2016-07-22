library(ggplot2)
mpg

# 2.2.1) 5 functions to use to get more information out of dataset
summary(mpg)
pairs(~year+cyl+displ+cty+hwy, mpg)
table(mpg$class)
table(mpg$manufacturer)
names(mpg)
dim(mpg)

# 2.2.2) Other datasets included with ggplot2
# Go to docs.ggplot2.org

# 2.2.3) Convert cty and hwy to Euro standard of liters/100km
mpg$ctykm <- (1 / mpg$cty) * (62.1371) * (1 / 0.264172)
mpg$hwykm <- (1 / mpg$hwy) * (62.1371) * (1 / 0.264172)

# 2.2.4a Manufacturers with most models
library(plyr)
count(mpg, c("manufacturer"))
count(mpg, c("manufacturer", "model"))

# Example
# Data + aesthetic mappings + geom layer
ggplot(mpg, aes(x=displ, y=hwy)) +
  geom_point()

# 2.3.1 relationship between cty and hwy
ggplot(mpg, aes(cty, hwy)) +
  geom_point()
# These are highly correlated and of course will have a high
# degree of collinearity

# 2.3.2
ggplot(mpg, aes(model, manufacturer)) +
  geom_point()
# Not sure how this is useful, maybe assign a number to the 
# models by mfr and do a stem and leaf plot?

# Examples
# Assigns a different color to every class of car
ggplot(mpg, aes(displ, cty, color=class)) +
  geom_point()

# These look pink!
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color="blue"))

# These are actually blue
ggplot(mpg, aes(displ, hwy)) +
  geom_point(color="blue")

# Help doc that shows aesthetic inputs
vignette("ggplot2-specs")

# 2.4.1 Experiment
# color
ggplot(mpg, aes(displ, cty, color=class)) +
  geom_point()
ggplot(mpg, aes(displ, cty, color=hwykm)) +
  geom_point()

# shape
ggplot(mpg, aes(displ, cty, shape=class)) +
  geom_point()
ggplot(mpg, aes(displ, cty, shape=hwykm)) +
  geom_point() #ERROR

# size
ggplot(mpg, aes(displ, cty, size=class)) +
  geom_point()
ggplot(mpg, aes(displ, cty, size=hwykm)) +
  geom_point() 

# more than one 
ggplot(mpg, aes(displ, cty, color=class, size=hwykm)) +
  geom_point()

# 2.3.2 map trans to shape
ggplot(mpg, aes(displ, cty, shape=trans)) +
  geom_point() # WARNINGS

# 2.3.3 Drive train and fuel economy
ggplot(mpg, aes(drv, cty, color=class)) +
  geom_point()
# front wheel drive associated with better fuel economy
ggplot(mpg, aes(drv, displ, color=class)) +
  geom_point()
# front wheel drives have smaller engines than rear
# no front wheel drive suvs or pickups

# Example - Facetting
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~class)

# 2.5.1 Facet by a continuous variable
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~cty)
# Bins by rounding, too many to be useful
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)
# difference is that the latter takes discrete values

# 2.5.2 fuel econ, engine size, # cyl
ggplot(mpg, aes(displ, hwy, color=class)) + 
  geom_point() + 
  facet_wrap(~cyl)

# Add smoothers
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth()

# turn off CE
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(se=FALSE)

#loess for small n
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(span=0.2)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(span=1)

# use a GAM
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(method = "gam", formula=y~s(x))

# use a linear model
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(method="lm")
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  geom_smooth(method="rlm")

# BOX PLOTS AND JITTERED POINTS
ggplot(mpg,aes(drv,hwy)) + geom_jitter()
ggplot(mpg,aes(drv,hwy)) + geom_boxplot()
ggplot(mpg,aes(drv,hwy)) + geom_violin()

# HISTOGRAMS AND FREQUENCY POLYGONS
ggplot(mpg, aes(hwy)) + geom_histogram()
ggplot(mpg, aes(hwy)) + geom_freqpoly()
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2.5)
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 1)

# comparing the fp to the histogram
ggplot(mpg, aes(displ, color=drv)) + geom_freqpoly(binwidth=0.5)
ggplot(mpg, aes(displ, fill=drv)) +
  geom_histogram(binwidth=0.5) +
  facet_wrap(~drv, ncol=1)

### BAR CHARTS
ggplot(mpg, aes(manufacturer)) + geom_bar()
# This is for unsummarized data, for summarized data do this
drugs <- data.frame(drug=c("a","b","c","d"), effect=c(4.2,9.7,6.1,8.3))
ggplot(drugs, aes(drug,effect)) + geom_bar(stat="identity")

### TIME SERIES
ggplot(economics, aes(date, unemploy/pop)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_line()

# Put both on the same graph
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_path() + geom_point()
# Can't tell how time flows in that one, add time to color
year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy/pop, uempmed)) +
  geom_path(color="grey50") +
  geom_point(aes(color=year(date)))

### EXERCISES 2.6
# 2.6.1) What's the problem?
ggplot(mpg, aes(cty, hwy)) + geom_point()
ggplot(mpg, aes(cty, hwy)) + geom_jitter()

# 2.6.2) What's the problem?
ggplot(mpg, aes(class, hwy)) + geom_boxplot()
# this would be better if the classes could be ranked by size somehow
ggplot(mpg, aes(reorder(class,hwy),hwy)) + geom_boxplot()

# 2.6.3) Bin width of carat in diamonds data
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.5)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.25)
ggplot(diamonds, aes(carat)) + geom_histogram(binwidth = 0.1)

# 2.6.4 How does the price of diamonds vary by cut?
summary(diamonds$price)
table(diamonds$cut)
ggplot(diamonds, aes(reorder(cut, price),price)) + geom_boxplot()


### MORE EXAMPLES

# Add axis labels
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha = 1/3)
ggplot(mpg, aes(cty, hwy)) + geom_point(alpha = 1/3) +
  xlab("city driving (mpg)") + 
  ylab("highway driving (mpg)")

# Change x and y limits
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25)
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25) +
  xlim("f","r") + 
  ylim(20,30)
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.25, na.rm=TRUE) +
  ylim(NA, 30)

### SAVING PLOTS
p <- ggplot(mpg, aes(displ, hwy, color=factor(cyl))) + geom_point()
print(p)
ggsave("plot.png", width=5, height=3)
summary(p)

### QUICK PLOTS
qplot(displ, hwy, data=mpg)
qplot(displ, data=mpg)
qplot(displ, hwy, data=mpg, color="blue")
qplot(displ, hwy, data=mpg, color=I("blue"))
