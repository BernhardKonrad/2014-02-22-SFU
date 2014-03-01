# Data visualization exercises

## Exercise 1

Using the mtcars dataset...

Make a plot of `mpg` vs. `hp` using the entire dataset. 

<!-- ggplot(mtcars, aes(mpg, hp)) + geom_point() -->

## Exercise 2 - facets

Using the `mtcars` dataset...

Make a plot with a different panel for each of the 3 levels of the `gear` column. With each panel in the same plot, not in different plots. Plot as the y-axis the column `mpg`, and the x-axis with `hp`. Hint: see `facet_wrap` or `facet_grid`.

<!-- ggplot(mtcars, aes(mpg, hp)) + geom_point() + facet_wrap(~gear) -->

## Exercise 3 - scales

Using the `diamonds` dataset...

Make a plot of `price` vs. `carat`, with a different line for each of the 5 unique values of `cut`. 

<!-- ggplot(diamonds, aes(carat, price, color = cut)) + geom_point() -->

## Exercise 4

Using the `diamonds` dataset...

Make a plot of `price` vs. `carat`, with a different line for each of the 5 unique values of `cut`. 

<!-- ggplot(diamonds, aes(carat, price, color = cut)) + geom_point() -->