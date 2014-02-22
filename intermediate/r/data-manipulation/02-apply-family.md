


# Learning the apply family of functions

One of the greatest joys of vectorized operations is being able to use the entire family of `apply` functions that are available in base `R`.

These include:


```r
apply
by
lapply
tapply
sapply
```


## apply

`apply` applies a function to each row or column of a matrix.


```r
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)
m
```

```
##       [,1] [,2]
##  [1,]    1   11
##  [2,]    2   12
##  [3,]    3   13
##  [4,]    4   14
##  [5,]    5   15
##  [6,]    6   16
##  [7,]    7   17
##  [8,]    8   18
##  [9,]    9   19
## [10,]   10   20
```

```r
# 1 is the row index
# 2 is the column index
apply(m, 1, sum)
```

```
##  [1] 12 14 16 18 20 22 24 26 28 30
```

```r
apply(m, 2, sum)
```

```
## [1]  55 155
```

```r
apply(m, 1, mean)
```

```
##  [1]  6  7  8  9 10 11 12 13 14 15
```

```r
apply(m, 2, mean)
```

```
## [1]  5.5 15.5
```


## by

`by` applies a function to subsets of a data frame.


```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
by(iris[, 1:2], iris[,"Species"], summary)
```

```
## iris[, "Species"]: setosa
##   Sepal.Length   Sepal.Width  
##  Min.   :4.30   Min.   :2.30  
##  1st Qu.:4.80   1st Qu.:3.20  
##  Median :5.00   Median :3.40  
##  Mean   :5.01   Mean   :3.43  
##  3rd Qu.:5.20   3rd Qu.:3.67  
##  Max.   :5.80   Max.   :4.40  
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.00  
##  1st Qu.:5.60   1st Qu.:2.52  
##  Median :5.90   Median :2.80  
##  Mean   :5.94   Mean   :2.77  
##  3rd Qu.:6.30   3rd Qu.:3.00  
##  Max.   :7.00   Max.   :3.40  
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
##   Sepal.Length   Sepal.Width  
##  Min.   :4.90   Min.   :2.20  
##  1st Qu.:6.22   1st Qu.:2.80  
##  Median :6.50   Median :3.00  
##  Mean   :6.59   Mean   :2.97  
##  3rd Qu.:6.90   3rd Qu.:3.17  
##  Max.   :7.90   Max.   :3.80
```

```r
by(iris[, 1:2], iris[,"Species"], sum)
```

```
## iris[, "Species"]: setosa
## [1] 421.7
## -------------------------------------------------------- 
## iris[, "Species"]: versicolor
## [1] 435.3
## -------------------------------------------------------- 
## iris[, "Species"]: virginica
## [1] 478.1
```



## tapply

`tapply` applies a function to subsets of a vector.


```r
df <- data.frame(names = sample(c("A","B","C"), 10, rep = TRUE), length = rnorm(10))
df
```

```
##    names  length
## 1      C -0.4179
## 2      B -0.3464
## 3      A -1.4245
## 4      B -0.4972
## 5      C  0.4913
## 6      B  1.1409
## 7      A -0.3894
## 8      B -0.3305
## 9      A  0.3404
## 10     B -0.5575
```

```r
tapply(df$length, df$names, mean)
```

```
##        A        B        C 
## -0.49116 -0.11816  0.03673
```


Now with a more familiar dataset.


```r
tapply(iris$Petal.Length, iris$Species, mean)
```

```
##     setosa versicolor  virginica 
##      1.462      4.260      5.552
```


## lapply (and llply from plyr)

What it does: Returns a list of same length as the input. 
Each element of the output is a result of applying a function to the corresponding element.


```r
my_list <- list(a = 1:10, b = 2:20)
my_list
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
lapply(my_list, mean)
```

```
## $a
## [1] 5.5
## 
## $b
## [1] 11
```




## sapply

`sapply` is a more user friendly version of `lapply` and will return a list of matrix where appropriate.


Let's work with the same list we just created.


```r
my_list
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1]  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

```r
x <- sapply(my_list, mean)
x
```

```
##    a    b 
##  5.5 11.0
```

```r
class(x)
```

```
## [1] "numeric"
```


## vapply

`sapply` is more commonly used, but especially when inside a function, use `vapply` as (1) it can be faster and (2) you can check that each element is the right data type. Note that the 3rd argument to `vapply` is a check on the data type. This passes


```r
vec <- 1:10
vapply(vec, sqrt, 1)
```

```
##  [1] 1.000 1.414 1.732 2.000 2.236 2.449 2.646 2.828 3.000 3.162
```


But this throws an error


```r
vec <- 1:10
vapply(vec, sqrt, "")
```

```
## Error: values must be type 'character',
##  but FUN(X[[1]]) result is type 'double'
```



## replicate

An extremely useful function to generate datasets for simulation purposes.


```r
replicate(10, rnorm(10))
```

```
##          [,1]     [,2]      [,3]    [,4]     [,5]    [,6]    [,7]    [,8]
##  [1,] -1.2547 -0.62436  0.231404 -1.7053  1.92107  1.9379 -1.1859  0.9655
##  [2,]  3.0928 -0.09139 -0.052822  0.3721  0.03041 -0.8908 -0.7812  0.2601
##  [3,]  2.5512 -0.78315  0.615653  1.2596  1.34452  2.3015 -0.1004 -0.4955
##  [4,] -1.4531  0.28996 -0.245113 -0.9732  1.10691 -0.1338 -0.2786 -0.6031
##  [5,] -0.1107 -0.15937 -0.187425 -0.8061  0.65638  2.1739 -0.4025 -0.2940
##  [6,] -1.1737  2.04663 -1.180223  0.5503  0.18174 -1.1960  1.4512 -0.1857
##  [7,]  1.1567  0.86742 -1.033866  1.3578  1.85217  0.0157 -1.9090 -1.4447
##  [8,]  0.2294  0.80641 -0.001021 -0.9725 -0.37780 -0.3064 -1.3520  2.0127
##  [9,] -0.4501  0.58111 -0.438699 -0.8619 -0.90791 -0.3493  0.3964 -1.1737
## [10,]  2.1447  0.16312 -0.294766 -0.5859 -0.83110  1.4934  0.3034 -0.1361
##           [,9]   [,10]
##  [1,] -0.23598 -0.1019
##  [2,] -0.90548 -0.3805
##  [3,] -0.00656  0.5442
##  [4,]  1.12548 -0.2587
##  [5,] -1.04686 -0.1078
##  [6,]  0.05958  0.8788
##  [7,] -0.03948  0.2623
##  [8,] -1.43748  0.1885
##  [9,] -1.41845 -0.9018
## [10,]  0.48939  2.6296
```

```r
replicate(10, rnorm(10), simplify = TRUE)
```

```
##          [,1]      [,2]     [,3]     [,4]      [,5]     [,6]    [,7]
##  [1,] -0.4196 -0.006988  1.06159 -0.01225 -0.002036  0.46806  1.4620
##  [2,] -0.5775  1.291848  0.90686  0.02265  0.428502  2.50979  0.3275
##  [3,] -1.1664 -1.748042 -0.62541  0.41487  0.937891 -0.07845  0.3050
##  [4,] -0.8642 -0.400899 -0.28894 -0.35364 -0.099291 -0.37448 -0.4496
##  [5,]  0.1194  0.113588  1.58224 -1.52788  0.573315  0.08363 -1.6557
##  [6,]  1.0336  2.164564  1.16855  0.49611  0.445657  2.13596 -0.8783
##  [7,]  1.0785 -0.498568  0.01593  0.64866 -1.029114  1.89811  0.4993
##  [8,]  1.8896  0.731159  2.02517  0.01319  0.162813  0.41811  0.7403
##  [9,]  1.1991 -0.369146  1.14733  0.03288 -0.007508  0.63575  1.6552
## [10,] -0.7679 -0.460486 -0.20704  0.84943  0.041299  0.27220 -0.6651
##           [,8]    [,9]     [,10]
##  [1,] -0.84230 -0.8492  1.955188
##  [2,]  1.78296  1.6579 -1.242288
##  [3,] -0.66589 -0.5326 -0.838588
##  [4,] -0.99398 -1.7870 -0.325690
##  [5,]  0.37715  0.6737  0.314647
##  [6,] -0.62315  0.2809  0.007918
##  [7,] -1.54079 -1.0056  0.557831
##  [8,]  1.58226 -0.7431 -1.386456
##  [9,] -0.05668 -0.4459 -1.014863
## [10,]  0.23239  0.9050  0.305148
```


The final arguments turns the result into a vector or matrix if possible.

## mapply
Its more or less a multivariate version of `sapply`. It applies a function to all corresponding elements of each argument. 

example:


```r
list_1 <- list(a = c(1:10), b = c(11:20))
list_1
```

```
## $a
##  [1]  1  2  3  4  5  6  7  8  9 10
## 
## $b
##  [1] 11 12 13 14 15 16 17 18 19 20
```

```r
list_2 <- list(c = c(21:30), d = c(31:40))
list_2
```

```
## $c
##  [1] 21 22 23 24 25 26 27 28 29 30
## 
## $d
##  [1] 31 32 33 34 35 36 37 38 39 40
```

```r
mapply(sum, list_1$a, list_1$b, list_2$c, list_2$d)
```

```
##  [1]  64  68  72  76  80  84  88  92  96 100
```




