


# Input output operations

## Inputting data


```r
x <- scan("data_file.txt")
# add a separator
x <- scan("data/messy_data.txt", what=" ", sep = "\n")

# or read data from the console
x <- scan()
# keep entering values and hit an empty return key to end
```

Reading single lines (e.g. user input)


```r
variable <- readline()
# or provide more information
variable <- readline("Enter number of simulations: ")
```



## Reading files  
Most plain text files can be read with `read.table` or variants thereof (such as `read.csv`).


```r
df <- read.table("messy_data.txt", header = TRUE)
head(df)
```


What is this header business?  When would you set header=FALSE vs. TRUE?

or using `readLines`


```r
dt <- readLines("data/messy_data.txt")
head(dt)
```

```
## [1] "J. Pritchard    01/12 - 12/11  1 1500 W  7.0 420 48  Migratory 3"
## [2] "E. Jones  02/18 - 04/21  4 1293 N  8.0 490 48  Resident 1"       
## [3] "J. Pritchard   01/13 - 02/17   15 1028 N  4.0 46  460 Migratory" 
## [4] "Matt Jones   09/23 - 11/23  23 563 N   3.0 470 47  Resident 2"   
## [5] "S. Chamberlain 07/05 - 09/26 22  713 N   5.2 500 45  Resident 4" 
## [6] "C. Boettiger 10/24 - 10/30   1495 S 30 1.9 47  410 Migratory"
```


## Files from the web


```r
url <- "data/climate.csv"
my_data <- read.csv(url, header = TRUE)
head(my_data)
```

```
##     X   Source Year Anomaly1y Anomaly5y Anomaly10y Unc10y
## 1 102 Berkeley 1901        NA        NA     -0.162  0.109
## 2 103 Berkeley 1902        NA        NA     -0.177  0.108
## 3 104 Berkeley 1903        NA        NA     -0.199  0.104
## 4 105 Berkeley 1904        NA        NA     -0.223  0.105
## 5 106 Berkeley 1905        NA        NA     -0.241  0.107
## 6 107 Berkeley 1906        NA        NA     -0.294  0.106
```


## Local file operations

One can list files from any local source as well.


```r
list.files()
file.info()
dir()
file.exists()
getwd()
setwd()
```


How do you denote your home directory on your computer?


---



## Writing files

Saving files is easy in R. Load the `iris` dataset by running `data(iris)`. Can you save this back to a `csv` file to disk with the name `tgac_iris.csv`?

What commands did you use?


### Short term storage


```r
saveRDS(iris, file = "my_iris.rds")
iris_data <- readRDS("my_iris.rds")
unlink("my_iris.rds")
```

This is great for short term storage. All factors and other modfications to the dataset will be preserved. However, only R can read these data back and not the best option if you want to keep the file stored in the easiest format.

### Long-term storage


```r
write.csv(iris, file = "my_iris.csv", row.names = FALSE)
```


### Easy to store compressed files to save space:


```r
write.csv(diamonds, file = bzfile("diamonds.csv.bz2"),
  row.names = FALSE)
```


### Reading is even easier:


```r
diamonds5 <- read.csv("diamonds.csv.bz2")
```


Files stored with `saveRDS()` are automatically compressed.


# Fast reading! for those with big files

`data.table` has a great function called `fread` that reads faster than other functions. 


```r
library(data.table)
fread("file.csv")
```

