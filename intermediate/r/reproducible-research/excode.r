## ---- thing1 ----
a <- rnorm(1000)
hist(a)

## ---- thing2 ----
library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point()