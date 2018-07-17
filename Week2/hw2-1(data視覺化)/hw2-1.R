#install.packages("ggplot2")
library(ggplot2)

iris

ggplot(data = iris, aes(x = Species)) + geom_bar(fill = "lightpink", colour = "black")

ggplot(data = iris, aes(x = Sepal.Length)) + geom_histogram(fill = "lightpink", colour = "black")

ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + geom_point()

ggplot(data = iris, aes(x = Species, y = Sepal.Length)) + geom_boxplot()

library(ggplot2)
library(GGally)
library(scales)
library(memisc)

ggpairs(iris)
