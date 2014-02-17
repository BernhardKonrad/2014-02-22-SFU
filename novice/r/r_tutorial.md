---
layout: lesson
root: ../..
title: Miami Bootcamp R Tutorial
---

##<a name="top"></a>Outline

1. [R Basics](#basics)
2. [Data Structures and Basic Use](#datastructures)
3. [Control Structures and Functions](#controlstructures)
	* [Challenge Exercises 1](#challenge1)
4. [Split-Apply-Combine (plyr)](#sac)
5. [Plotting (ggplot)](#plotting)
   * [Challenge Exercises 2](#challenge2)
6. [Extras](#Extras)
	
<i>Vince Melfi's [Introduction to R tutorial](IntroR.pdf) from CSTAT workshop in 2011 was used in the creation of this tutorial.</i>

---

###<a name="basics"></a><font color='blue'>1. R Basics</font>

####Installing R

Before we start this tutorial, please make sure to install R on your local machines. 

[Download R](http://cran.rstudio.com/) from the Comprehensive R Archive Network (CRAN) and install following instructions. 

We will also be using an R IDE (integrated development environment) called RStudio. To install RStudio, [download the installer](http://www.rstudio.com/ide/download/desktop) recommended for your machine. 

####Getting Help with R

There is a help function in R, and also a web-based help interface that allows easier searching and other functionality. 

The function `help.start()` opens a web-based interface that is a good place to start for general help.

If you need help understanding how to use a particular function, for example `median()`, use the following commands:

```
> help(median)    # help about function median
> ?median         # help about function median
> example(median) # example of function median
```

####Packages

Functions and datasets in R are often provided as part of a <i><b>package</b></i>. For example,
the `stats` package contains functions for commonly used statistical procedures; the
`cluster` package contains functions for cluster analysis; and the `affy` package contains
functions for analysis of Affymetrix microarrays. Some packages are included in the
default R distribution and are loaded into any R session by default (for example, the
stats package), while others must be installed and loaded by the user.

The `library()` command (with no arguments) lists the packages that are <i>installed</i>.
Of these, some may be loaded for use, and others may not. The `search()` command
lists those packages that are <i>loaded</i>. Output of these commands will vary depending
on the installation.

To install a package, use the `install.packages()` function (this will likely ask you for a CRAN mirror the first time downloading, just pick one):

```
> install.packages("vegan")
Installing package(s) into ‘/Library/Frameworks/R.framework/Versions/2.15/Resources/library’
(as ‘lib’ is unspecified)
trying URL 'http://cran.rstudio.com/bin/macosx/leopard/contrib/2.15/vegan_2.0-7.tgz'
Content type 'application/x-gzip' length 2371908 bytes (2.3 Mb)
opened URL
==================================================
downloaded 2.3 Mb


The downloaded binary packages are in
	/var/folders/_x/wbqc14lj1x7d6602h5nxr55m0000gn/T//RtmprP5Wvc/downloaded_packages
```

```
> search()
 [1] ".GlobalEnv"        "tools:rstudio"     "package:stats"     "package:graphics"  "package:grDevices" "package:utils"     "package:datasets"  "package:methods"  
 [9] "Autoloads"         "package:base" 
```

To load a package, use the `library()` function:

```
> library("vegan")
Loading required package: permute
This is vegan 2.0-7
Warning message:
package ‘vegan’ was built under R version 2.15.3 
```
```
> search()
 [1] ".GlobalEnv"        "package:vegan"     "package:permute"   "tools:rstudio"     "package:stats"     "package:graphics"  "package:grDevices" "package:utils"    
 [9] "package:datasets"  "package:methods"   "Autoloads"         "package:base"  
```


---

###<a name="datastructures"></a><font color='blue'>2. Data Structures and Basic Use</font>

Throughout the tutorial today, we will be using a metadata of microbial  genomes
from the [Integrated Microbial Genomes (IMG)](http://img.jgi.doe.gov/) database. We will start of a small subset of this data, including the phylum, genome size, and gene count shown below:


| IMG_ID    | Phylum              | Genome_Size | Gene_Count |
|-----------|---------------------|-------------:|------------:|
| 637000001 | Acidobacteria       | 5650368     | 4837       |
| 637000031 | Actinobacteria      | 2260266     | 1805       |
| 637000082 | Actinobacteria      | 2488635     | 2395       |
| 637000085 | Actinobacteria      | 2476822     | 2186       |
| 637000010 | Aquificae           | 1590791     | 1613       |
| 637000024 | Bacteroidetes       | 5241700     | 4403       |
| 637000087 | Bacteroidetes       | 4433218     | 3843       |
| 637000059 | Chlamydiae          | 2414465     | 2079       |
| 637000071 | Chlamydiae          | 1225935     | 1157       |
| 637000072 | Chlorobi            | 2572079     | 2100       |
| 637000073 | Chlorobi            | 2154946     | 2317       |
| 637000089 | Chloroflexi         | 1469720     | 1647       |
| 637000090 | Chloroflexi         | 1395502     | 1517       |
| 637000020 | Firmicutes          | 4202352     | 4239       |
| 637000023 | Firmicutes          | 5314794     | 5452       |
| 637000060 | Firmicutes          | 2401520     | 2738       |
| 637000008 | Proteobacteria      | 1197687     | 1006       |
| 637000009 | Proteobacteria      | 1471282     | 1335       |
| 637000012 | Proteobacteria      | 4727255     | 4686       |
| 637000036 | Spirochaetes        | 1519856     | 1690       |
| 637000011 | Tenericutes         | 723970      | 734        |


####Overview of Data Structures

#####Data vectors

A <b>vector</b> can be thought of as a way to store the values of one variable. For example, we can create a <b>vector</b>
of all of the genome sizes:

```
> Genome_Size = c(5650368, 2260266, 2488635, 2476822, 1590791, 5241700, 4433218, 2414465, 1225935, 2572079, 
+	              2154946, 1469720, 1395502, 3284156, 4202352, 5314794, 2401520, 1197687, 1471282, 4727255, 
+                 1519856, 723970)
> Genome_Size
 [1] 5650368 2260266 2488635 2476822 1590791 5241700 4433218 2414465 1225935 2572079 2154946 1469720 1395502
[14] 3284156 4202352 5314794 2401520 1197687 1471282 4727255 1519856  723970
```

Notice a few things:

1. The name `Genome_Size` is the name of the vector containing genome sizes. 

2. The R function `c()` is used to <i>concatenate</i> several data values into one vector. 

3. To see what is in an object like `Genome_Size`, just type the name. 

4. When R displays the values of an object like `Genome_Size`,it indicated in square brackets the position of the first data value displayed on a line. For example, `[14]` next to the data value `3284156` indicates that this is the fourtenth value in the `Genome_Size` data vector. 

It is important to note that objects in R are case sensitive:

```
> Genome_size
Error: object 'Genome_size' not found
> genome_size
Error: object 'genome_size' not found
> genome_Size
Error: object 'genome_Size' not found
>
```

Let's make another data vector for `Gene_Count`:

```
> Gene_Count = c(4837,1805,2395,2186,1613,4403,3843,2079,1157,2100,2317,1647,
+                 1517,3249,4239,5452,2738,1006,1335,4686,1690,734)
> Gene_Count
 [1] 4837 1805 2395 2186 1613 4403 3843 2079 1157 2100 2317 1647 1517 3249 4239 5452 2738 1006 1335 4686 1690
[22]  734
>
```

The `Genome_Size` vector contains all numbers, or numericals. Data vectors can also contain character data or logical data. For example, if we wanted a vector containing the phyla for each of the genomes we are interested in:

```
> Phyla = c("Acidobacteria","Actinobacteria","Actinobacteria","Actinobacteria","Aquificae",
+           "Bacteroidetes","Bacteroidetes", "Chlamydiae","Chlamydiae","Chlorobi","Chlorobi","Chloroflexi",
+           "Chloroflexi","Deinococcus-Thermus", "Firmicutes","Firmicutes","Firmicutes","Proteobacteria",
+           "Proteobacteria","Proteobacteria","Spirochaetes","Tenericutes")
> Phyla
 [1] "Acidobacteria"       "Actinobacteria"      "Actinobacteria"      "Actinobacteria"     
 [5] "Aquificae"           "Bacteroidetes"       "Bacteroidetes"       "Chlamydiae"         
 [9] "Chlamydiae"          "Chlorobi"            "Chlorobi"            "Chloroflexi"        
[13] "Chloroflexi"         "Deinococcus-Thermus" "Firmicutes"          "Firmicutes"         
[17] "Firmicutes"          "Proteobacteria"      "Proteobacteria"      "Proteobacteria"     
[21] "Spirochaetes"        "Tenericutes"        
```

Note that the values are specified in quotes, telling R that these are <b>character</b> values.

Importantly, data vectors can only hold <i>one</i> type of data value. For example, we can have a vector that holds both numeric values and character values. For example, suppose we tried to concatenate the two data vectors `Phyla` and `Genome_Size` into a vector called `Combined_Data`:

```
> Combined_Data = c(Phyla, Genome_Size)
> Combined_Data
 [1] "Acidobacteria"       "Actinobacteria"      "Actinobacteria"      "Actinobacteria"     
 [5] "Aquificae"           "Bacteroidetes"       "Bacteroidetes"       "Chlamydiae"         
 [9] "Chlamydiae"          "Chlorobi"            "Chlorobi"            "Chloroflexi"        
[13] "Chloroflexi"         "Deinococcus-Thermus" "Firmicutes"          "Firmicutes"         
[17] "Firmicutes"          "Proteobacteria"      "Proteobacteria"      "Proteobacteria"     
[21] "Spirochaetes"        "Tenericutes"         "5650368"             "2260266"            
[25] "2488635"             "2476822"             "1590791"             "5241700"            
[29] "4433218"             "2414465"             "1225935"             "2572079"            
[33] "2154946"             "1469720"             "1395502"             "3284156"            
[37] "4202352"             "5314794"             "2401520"             "1197687"            
[41] "1471282"             "4727255"             "1519856"             "723970"             
```

If vectors of different types are combined as in the example above, R will change them all to one type (known as <i>value coercion</i>). We can see here that R forced all of the numeric values for Genome_Size to character values, indicated by the quotes. The output type is determined from the highest type of the components in the hierarchy: `raw < logical < integer < double < complex < character < list`.

You can always tell what data type is by using the ```class``` function:

```
> class(Phyla)
[1] "character"
> class(Genome_Size)
[1] "numeric"
> class(Gene_Count)
[1] "numeric"
> class(Combined_Data)
[1] "character"
>
```

#####Matrices
So far, we have created three vector objects, `Phyla`, `Genome_Size`, and `Gene_Count`. It would be nice to have a data structure that could hold more than one variable. <b>Matrices</b> are one such structure. The R functions `matrix()`, `rbind()`, and `cbind()`, are all useful for creating matrices. 

First, we will use the ```matrix()``` function to create a matrix with four rows and three columns containing the integers from 1 through 12. (Rather than typing the 12 numbers explicitly, we will use <i>series</i> notation `1:12`, which returns all twelve numbers - more on this later.)

```
> mat1 = matrix(data = 1:12, nrow = 4, ncol = 3)
> mat1
     [,1] [,2] [,3]
[1,]    1    5    9
[2,]    2    6   10
[3,]    3    7   11
[4,]    4    8   12

```


Note that we specied the values to be entered in the matrix via the `data` argument,
the number of rows via the `nrow` argument, and the number of columns via the `ncol`
argument. 

In `mat1` the matrix was filled "by column," i.e., the first column was filled with thefirst four numbers, the second column was filled with the next four numbers, etc. We
can change this behavior by using the by row argument:

```
> mat2 = matrix(data = 1:12, nrow = 4, ncol = 3, byrow = T)
> mat2
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
[4,]   10   11   12
```

Now, let's make a matrix with the genome size and gene count data that we have currently in vector form. To do this we will use a combination of the `matrix()` and `c()` functions:

```
> Genome_Numbers = matrix(data = c(Genome_Size, Gene_Count), nrow = 22)
> Genome_Numbers
         [,1] [,2]
 [1,] 5650368 4837
 [2,] 2260266 1805
 [3,] 2488635 2395
 [4,] 2476822 2186
 [5,] 1590791 1613
 [6,] 5241700 4403
 [7,] 4433218 3843
 [8,] 2414465 2079
 [9,] 1225935 1157
[10,] 2572079 2100
[11,] 2154946 2317
[12,] 1469720 1647
[13,] 1395502 1517
[14,] 3284156 3249
[15,] 4202352 4239
[16,] 5314794 5452
[17,] 2401520 2738
[18,] 1197687 1006
[19,] 1471282 1335
[20,] 4727255 4686
[21,] 1519856 1690
[22,]  723970  734
```

This syntax can be a little tricky, because what is is first doing is <i>concatinating</i> the `Genome_Size` and `Gene_Count` vectors into one long vector of length 44 and <i>then</i> it is filling a matrix <i>by column</i> up to 22 rows. 

The `rbind()` and `cbind()` function provide a somewhat easier and more intuitive way to join together several equal length vectors into a matrix:

```
> Genome_Numers2 = cbind(Genome_Size, Gene_Count)
> Genome_Numers2
      Genome_Size Gene_Count
 [1,]     5650368       4837
 [2,]     2260266       1805
 [3,]     2488635       2395
 [4,]     2476822       2186
 [5,]     1590791       1613
 [6,]     5241700       4403
 [7,]     4433218       3843
 [8,]     2414465       2079
 [9,]     1225935       1157
[10,]     2572079       2100
[11,]     2154946       2317
[12,]     1469720       1647
[13,]     1395502       1517
[14,]     3284156       3249
[15,]     4202352       4239
[16,]     5314794       5452
[17,]     2401520       2738
[18,]     1197687       1006
[19,]     1471282       1335
[20,]     4727255       4686
[21,]     1519856       1690
[22,]      723970        734
```
```
> Genome_Numers3 = rbind(Genome_Size, Gene_Count)
> Genome_Numers3
               [,1]    [,2]    [,3]    [,4]    [,5]    [,6]    [,7]    [,8]    [,9]   [,10]   [,11]   [,12]
Genome_Size 5650368 2260266 2488635 2476822 1590791 5241700 4433218 2414465 1225935 2572079 2154946 1469720
Gene_Count     4837    1805    2395    2186    1613    4403    3843    2079    1157    2100    2317    1647
              [,13]   [,14]   [,15]   [,16]   [,17]   [,18]   [,19]   [,20]   [,21]  [,22]
Genome_Size 1395502 3284156 4202352 5314794 2401520 1197687 1471282 4727255 1519856 723970
Gene_Count     1517    3249    4239    5452    2738    1006    1335    4686    1690    734

```

Note one difference here: the column names or the row names are now the names of the original vectors.

Again, it is important to note that all elements of matrices are requred to be the same type (just as vectors):

```
> Genomes = cbind(Phyla,Genome_Size, Gene_Count)
> Genomes
      Phyla                 Genome_Size Gene_Count
 [1,] "Acidobacteria"       "5650368"   "4837"    
 [2,] "Actinobacteria"      "2260266"   "1805"    
 [3,] "Actinobacteria"      "2488635"   "2395"    
 [4,] "Actinobacteria"      "2476822"   "2186"    
 [5,] "Aquificae"           "1590791"   "1613"    
 [6,] "Bacteroidetes"       "5241700"   "4403"    
 [7,] "Bacteroidetes"       "4433218"   "3843"    
 [8,] "Chlamydiae"          "2414465"   "2079"    
 [9,] "Chlamydiae"          "1225935"   "1157"    
[10,] "Chlorobi"            "2572079"   "2100"    
[11,] "Chlorobi"            "2154946"   "2317"    
[12,] "Chloroflexi"         "1469720"   "1647"    
[13,] "Chloroflexi"         "1395502"   "1517"    
[14,] "Deinococcus-Thermus" "3284156"   "3249"    
[15,] "Firmicutes"          "4202352"   "4239"    
[16,] "Firmicutes"          "5314794"   "5452"    
[17,] "Firmicutes"          "2401520"   "2738"    
[18,] "Proteobacteria"      "1197687"   "1006"    
[19,] "Proteobacteria"      "1471282"   "1335"    
[20,] "Proteobacteria"      "4727255"   "4686"    
[21,] "Spirochaetes"        "1519856"   "1690"    
[22,] "Tenericutes"         "723970"    "734"  
```

#####Data Frames

Data frames are the most common way to organize several variables in a data set. Unlike matrices and vectors, the variables don't have to all be of the same type. Let's make a data frame containing all of the genome data:

```
> Genomes.data = data.frame(Phyla, Genome_Size, Gene_Count)
> Genomes.data
                 Phyla Genome_Size Gene_Count
1        Acidobacteria     5650368       4837
2       Actinobacteria     2260266       1805
3       Actinobacteria     2488635       2395
4       Actinobacteria     2476822       2186
5            Aquificae     1590791       1613
6        Bacteroidetes     5241700       4403
7        Bacteroidetes     4433218       3843
8           Chlamydiae     2414465       2079
9           Chlamydiae     1225935       1157
10            Chlorobi     2572079       2100
11            Chlorobi     2154946       2317
12         Chloroflexi     1469720       1647
13         Chloroflexi     1395502       1517
14 Deinococcus-Thermus     3284156       3249
15          Firmicutes     4202352       4239
16          Firmicutes     5314794       5452
17          Firmicutes     2401520       2738
18      Proteobacteria     1197687       1006
19      Proteobacteria     1471282       1335
20      Proteobacteria     4727255       4686
21        Spirochaetes     1519856       1690
22         Tenericutes      723970        734

```

Note that here `Phyla` has been converted from `character` to `factor`. We can see this by looking at the structure of the object using `str()`:

```
> str(Genomes.data)
'data.frame':	22 obs. of  3 variables:
 $ Phyla      : Factor w/ 12 levels "Acidobacteria",..: 1 2 2 2 3 4 4 5 5 6 ...
 $ Genome_Size: num  5650368 2260266 2488635 2476822 1590791 ...
 $ Gene_Count : num  4837 1805 2395 2186 1613 …
```

We haven't talked about `factors` yet, but they are useful for handling nominal and ordered <i>categorical</i> data.  To avoid this you can set the `stringsAsFactors` argument to `FALSE`:

```
> Genomes.data = data.frame(Phyla, Genome_Size, Gene_Count, stringsAsFactors=FALSE)
> Genomes.data
                 Phyla Genome_Size Gene_Count
1        Acidobacteria     5650368       4837
2       Actinobacteria     2260266       1805
3       Actinobacteria     2488635       2395
4       Actinobacteria     2476822       2186
5            Aquificae     1590791       1613
6        Bacteroidetes     5241700       4403
7        Bacteroidetes     4433218       3843
8           Chlamydiae     2414465       2079
9           Chlamydiae     1225935       1157
10            Chlorobi     2572079       2100
11            Chlorobi     2154946       2317
12         Chloroflexi     1469720       1647
13         Chloroflexi     1395502       1517
14 Deinococcus-Thermus     3284156       3249
15          Firmicutes     4202352       4239
16          Firmicutes     5314794       5452
17          Firmicutes     2401520       2738
18      Proteobacteria     1197687       1006
19      Proteobacteria     1471282       1335
20      Proteobacteria     4727255       4686
21        Spirochaetes     1519856       1690
22         Tenericutes      723970        734
> str(Genomes.data)
'data.frame':	22 obs. of  3 variables:
 $ Phyla      : chr  "Acidobacteria" "Actinobacteria" "Actinobacteria" "Actinobacteria" ...
 $ Genome_Size: num  5650368 2260266 2488635 2476822 1590791 ...
 $ Gene_Count : num  4837 1805 2395 2186 1613 ...
```

At this point you may wonder why R has matrices, since a data frame seems a lot like
a matrix, but allows different types of variables. But R has powerful matrix functions
that operate on matrices with numerical entries, that are of great use in statistical
analysis. Examples include matrix algebra functions such as matrix multiplication,
transpose, etc., computing eigenvalues, and much more (which we won't be able to get into
today).

####Subscripting

Data analysis often requires selecting and possibly altering specific variables, or specific cases. For example, it may be necessary to correct an error in the height of the third subject. Or it may be desired to select the first and third vairable for all subjects who are male. Or data may need conversion from degrees Celsius to degrees Fahrenheit. R has powerful subscripting capability for this purpose.

Selecting specific elements of vectors and matrices is simple. Let's use the vector `Genome_Size` as example:

```
> Genome_Size
 [1] 5650368 2260266 2488635 2476822 1590791 5241700 4433218 2414465 1225935 2572079 2154946 1469720 1395502 3284156 4202352 5314794 2401520 1197687 1471282 4727255
[21] 1519856  723970
```

We can select an individual element from the vector:

```
> Genome_Size[2]
[1] 2260266
```

We can select the last element or the second to last element from the vector:

```
> length(Genome_Size)  # returns the length of the vector
[1] 22
> Genome_Size[length(Genome_Size)]
[1] 723970
> Genome_Size[length(Genome_Size)-1]
[1] 1519856
```

We can select the entire vector, removing certain elements:

```
> Genome_Size[-1]
 [1] 2260266 2488635 2476822 1590791 5241700 4433218 2414465 1225935 2572079 2154946 1469720 1395502 3284156 4202352 5314794 2401520 1197687 1471282 4727255 1519856
[21]  723970
```

We can select multiple elements from the vector:

```
> Genome_Size[1:5]
[1] 5650368 2260266 2488635 2476822 1590791
```

Or remove multiple elements from the vector:

```
> Genome_Size[-c(1:5)]
 [1] 5241700 4433218 2414465 1225935 2572079 2154946 1469720 1395502 3284156 4202352 5314794 2401520 1197687 1471282 4727255 1519856  723970
```

Next, let's look at subscripting using a matrix as an example:

```
> Genome_Numbers
         [,1] [,2]
 [1,] 5650368 4837
 [2,] 2260266 1805
 [3,] 2488635 2395
 [4,] 2476822 2186
 [5,] 1590791 1613
 [6,] 5241700 4403
 [7,] 4433218 3843
 [8,] 2414465 2079
 [9,] 1225935 1157
[10,] 2572079 2100
[11,] 2154946 2317
[12,] 1469720 1647
[13,] 1395502 1517
[14,] 3284156 3249
[15,] 4202352 4239
[16,] 5314794 5452
[17,] 2401520 2738
[18,] 1197687 1006
[19,] 1471282 1335
[20,] 4727255 4686
[21,] 1519856 1690
[22,]  723970  734
```

Selecting a single element in matrices always uses the notation `matrix[row,column]`:

```
> Genome_Numbers[1,2] # Returns the gene count of the first genome
[1] 4837
```

We can return series of numbers, just as in vectors:

```
> Genome_Numbers[1:5,2] # Returns the gene counts of the first five genomes
[1] 4837 1805 2395 2186 1613
```

We can select an indivudal row or column (note that this returns a vector):

```
> Genome_Numbers[1,] # Return information on first Genome
[1] 5650368    4837
> Genome_Numbers[,1] # Return all genome sizes
 [1] 5650368 2260266 2488635 2476822 1590791 5241700 4433218 2414465 1225935 2572079 2154946 1469720 1395502 3284156 4202352 5314794 2401520 1197687 1471282 4727255
[21] 1519856  723970
```

We can also select using the '-' notation like before:

```
> Genome_Numbers[1,-2]
[1] 5650368
```

Subscripting on `data frames` works the exact same way, except you can also select an element referring to the columns or rows by name. For example:

```
> Genomes.data
                 Phyla Genome_Size Gene_Count
1        Acidobacteria     5650368       4837
2       Actinobacteria     2260266       1805
3       Actinobacteria     2488635       2395
4       Actinobacteria     2476822       2186
5            Aquificae     1590791       1613
6        Bacteroidetes     5241700       4403
7        Bacteroidetes     4433218       3843
8           Chlamydiae     2414465       2079
9           Chlamydiae     1225935       1157
10            Chlorobi     2572079       2100
11            Chlorobi     2154946       2317
12         Chloroflexi     1469720       1647
13         Chloroflexi     1395502       1517
14 Deinococcus-Thermus     3284156       3249
15          Firmicutes     4202352       4239
16          Firmicutes     5314794       5452
17          Firmicutes     2401520       2738
18      Proteobacteria     1197687       1006
19      Proteobacteria     1471282       1335
20      Proteobacteria     4727255       4686
21        Spirochaetes     1519856       1690
22         Tenericutes      723970        734
```
```
> Genomes.data["Phyla"]
                 Phyla
1        Acidobacteria
2       Actinobacteria
3       Actinobacteria
4       Actinobacteria
5            Aquificae
6        Bacteroidetes
7        Bacteroidetes
8           Chlamydiae
9           Chlamydiae
10            Chlorobi
11            Chlorobi
12         Chloroflexi
13         Chloroflexi
14 Deinococcus-Thermus
15          Firmicutes
16          Firmicutes
17          Firmicutes
18      Proteobacteria
19      Proteobacteria
20      Proteobacteria
21        Spirochaetes
22         Tenericutes
```
```
> Genomes.data[1:5,"Phyla"]
[1] "Acidobacteria"  "Actinobacteria" "Actinobacteria" "Actinobacteria" "Aquificae"   
```
```
> Genomes.data[1:5,c("Phyla","Gene_Count")]
           Phyla Gene_Count
1  Acidobacteria       4837
2 Actinobacteria       1805
3 Actinobacteria       2395
4 Actinobacteria       2186
5      Aquificae       1613
```

Data frames also can use the "dollar sign operator" to extract entire vectors:

```
> Genomes.data$Phyla
 [1] "Acidobacteria"       "Actinobacteria"      "Actinobacteria"      "Actinobacteria"      "Aquificae"           "Bacteroidetes"       "Bacteroidetes"      
 [8] "Chlamydiae"          "Chlamydiae"          "Chlorobi"            "Chlorobi"            "Chloroflexi"         "Chloroflexi"         "Deinococcus-Thermus"
[15] "Firmicutes"          "Firmicutes"          "Firmicutes"          "Proteobacteria"      "Proteobacteria"      "Proteobacteria"      "Spirochaetes"       
[22] "Tenericutes"  
```
```
> Genomes.data$Phyla[1:5]
[1] "Acidobacteria"  "Actinobacteria" "Actinobacteria" "Actinobacteria" "Aquificae"   
```

####R Workspace and Working Directory

Before we go any further, let's talk about the <i>R workspace</i>. During an R session, objects are create and stored by name. The collections of objects currently stored is refered to as the <i>workspace</i>. To display all of the objects currently in the workspace use the function `ls()`:

```
> ls()
 [1] "Gene_Count"     "Genome_Data"    "Genome_Numbers" "Genome_Numers2" "Genome_Numers3" "Genome_Size"    "Genomes"        "Genomes.data"   "mat1"           "mat2"           "Phyla"   
```

You can remove objects from your workspace using the ```rm()``` function:

```
> rm(mat1,mat2)
```
```
> ls()
[1] "Gene_Count"     "Genome_Data"    "Genome_Numbers" "Genome_Numers2" "Genome_Numers3" "Genome_Size"    "Genomes"        "Genomes.data"   "Phyla"  
```

All of the objects in workspace can be stored permanently in a file for use in future R sessions in a `.RData` file. You can do this using the `save.image()` function. In a future R session, you can then load the workspace using the `load()` function:

```
> save.image("img_genomes.RData")
> load("img_genomes.RData")
```

It is important to note that when saving your workspace using the `save.image()` function, if you don't use a full path, it will save it to your current <i>working directory</i>. This is just the path where R thinks you are working. You can check where your current working directory is using `getwd()`:

```
> getwd()
[1] "/Users/mgibson"
```

and you can set your working directory using `setwd()`:

```
> setwd("/Users/mgibson/Documents/swcarpentry/2014-01-08-iastate/lessons/swc-r/data/")
> getwd()
[1] "/Users/mgibson/Documents/swcarpentry/2014-01-08-iastate/lessons/swc-r/data"
```


####Data I/O

Up until now, we have been importing data into R using the command line interface. We can also read data in directly from a spreadsheet using the function `read.table()` and export data from R using the `write.table()` function.

The `read.table()` funciton is the workhorse for reading data into R. At its simplest, the user need only specify the name of the file containing the data. Note that the file may be specified, for example, via a URL. The function `read.table()` always creates a data frame.

For example, we had been working with a small subset of the genome metadata from IMG. If we wanted to load the entire table to work with, we could do so using the `read.table()` function:

```
> microbial_genomes = read.table("http://cgs.wustl.edu/~mgibson/swc/microbial_genome.txt", header=T, sep="\t")
> microbial_genomes[1:5,1:5]
      IMG_ID   Domain Genome_Status                  Sequencing_Center         Phylum
1 2502171142 Bacteria         Draft          J. Craig Venter Institute    Tenericutes
2 2529292882 Bacteria         Draft                    Broad Institute Proteobacteria
3  649633017 Bacteria      Finished                      Univ of Tokyo Actinobacteria
4 2537561578 Bacteria         Draft Washington University in St. Louis Actinobacteria
5 2531839161 Bacteria         Draft                   Univ of Maryland     Firmicutes
``` 

The first argument specifies the location of the file, in this case it is a URL pointing to a file on a web server. The second argument, `header=T` tells R that the first line of the file contains variable names. The third argument tells R what character separates fields for an observation. The default for this is any blank space. This can also be useful if you want to read in `.csv` files as you can set `sep=","`. 

Again, by default `read.table()` converts character variables into factors. Usually this doesn't present problems, but sometimes users do not want this behavior, so you can set `stringsAsFactors = F`, just as we did with `data.frame()` above.

The funciton `write.table()` is the export counterpart to `read.table()`. For example, if we wanted to then write the data frame we just imported to a file, we could do:

```
> write.table(microbial_genomes, "microbial_genomes.txt", sep="\t", row.names = F)
```

This will write the data frame `img_genomes` to the files `img_genomes.txt` and fields will be separated by `"\t"`. The last argument is important if the rows for your data frame are not named, the default for `rows.names = T`.

[top](#top)

---

###<a name="controlstructures"></a><font color='blue'>3. Control Structures and Functions</font>

####Control Structures

R has all of the same control structures as most programming languages, including `for` loops, `while` loops, and `if-else` statements. We will first introduce these as an understanding of them is important to understanding basic programming practices as well as common functions and practices commonly employed using R. R has additional function for implicit looping such as `tapply`, `apply`, and `lapply` that we will talk about in the next section. 

#####Iteration and Looping

The `for` loop can be used to do something <i>for</i> all items in a vector or list:

```
for (item in a_vector){
	# operate on item
}
```

The `while` loop can be used for doing something <i>while</i> a logical statement is TRUE:

```
while (condition){
	# do something
	# update condition
}
```

#####Branching and Conditional Statements
Conditional statments allow us to execute a branch of code <i>if</i> a certain condition is satisfied. They also may include an <i>else</i> branch to be executed if the condition is not satisfied. 

This is done with an `if` statement and in R it looks like this:

```
if (condition) {
  ...
}
else {
  ...
}
```

The `ifelse` statement can operate on objects of variable length:

```
ifelse(test, true_value, false_value)
```

The condition is what we want to test if is TRUE and that is often done using <b>locginal comparisons</b>:

| Operator  | Meaning      | 
| --------- | -------------|
| == | equality |
| < | less than |
| > | greater than |
| <= | less than or equal to |
| >= | greater than or equal to |

and <b>binary operators</b>:
 
| Operator  | Meaning      | 
| --------- | -------------|
| && | AND 
| \|\| | OR 
| ! | NOT 


#####An Example

Using the `microbial_genomes` data frame that we imported using `read.table()`, let's calculate the average number of genes per genome for Proteobacteria and Actinobacteria genomes. 

One way we could do this is looping through all of the rows in the data frame and acting on each one of them independently:

```
> proteo_counts <- vector()
> actino_counts <- vector()
> for (entry_num in 1:length(microbial_genomes[,1])){
+     if (microbial_genomes[entry_num, "Phylum"] == "Proteobacteria"){
+         proteo_counts <- c(proteo_counts, microbial_genomes[entry_num, "Gene_Count"])
+     }
+     if (microbial_genomes[entry_num, "Phylum"] == "Actinobacteria"){
+         actino_counts <- c(actino_counts, microbial_genomes[entry_num, "Gene_Count"])
+     }
+ }
> mean(proteo_counts)
[1] 4113.335
> mean(actino_counts)
[1] 4232.623
```


####Functions
Functions are blocks of code that allows R to be modular and facilitate code reuse. An R programmer can define their own function as follows:

```
function_name <- function([arg1], [arg2],…){
	# function code body
}
```

Function arguments are the variables passed to the function, used by the function's code to perform clculations. 

Note, that the function arguments are optional. For example, `ls()` is a function with no arguments. If we use `ls` without the parenthesis, it is no longer calling the function and has a different behavior. 

A function can also return any object using the `return(object)` statement. 

For example, let's wrap the piece of code that we wrote above into a function, so that we can calculate the average gene count for any phylum:

```
average_gene_count <- function(microbial_genomes, phyla){
	counts <- vector()
	for (entry_num in 1:length(microbial_genomes[,1])){
		if (microbial_genomes[entry_num, "Phylum"] == phyla){
			counts <- c(counts, microbial_genomes[entry_num, "Gene_Count"])
		}
	}
	return(mean(counts))
}
```

We can now use this piece of code over and over again by just calling the funciton `average_gene_count()` and passing it the microbial_genomes dataset and the phyla we are interested in:

```
> average_gene_count(microbial_genomes, phyla="Proteobacteria")
[1] 4113.335
```
[top](#top)

---
###<a name="challenge1"></a><font color='red'>Challenge Exercises</font>

#### Exercise 1. 
1.1 Open R and examine your current working directory using `getwd()` and set your working directory to where you would like to work for today's exercises using `setwd()`.

1.2 Read the help and look at an example of how to use the function `mean()`.

What is the default for dealing with missing data (NA)?

What argument would you change so that you remove all missing data before caculating the mean?

1.3 Install (`install.packages(package)`) and load (`library(package)`) the packages `ggplot2` and `plyr`. 

<i>These packages will be used later in the tutorial. Just practice installing packages.</i>

Now, check to see what packages are installed using the  `library()` function and loaded using the `search()` function.


#### Exercise 2.
2.1 Read in the microbial genomes table from `http://cgs.wustl.edu/~mgibson/swc/microbial_genome.txt` using the function `read.table()`

Create a new vector from the `Genome_Size` column named `all_genome_sizes`. 

Create a new vector from the `GC_Percent` column named `all_gc_percent`.

2.2 Create a new matrix of all the genomes that has two columns `Genome_Size` and `GC_Percent` named `genome_content_m`.

Hint: Remember - use the `c()` and `matrix()` functions!

2.3 Create a data frame of all the genomes that has two columns `Genome_Size` and `GC_Percent` named `genome_content_df`.

What would be a faster way to do this that does not require creating two vectors?

#### Exercise 3.

3.1 Write a function called `average_phyla_16S()` that calculates the average number of 16S rRNA genes for a particular phyla that takes in the microbial_genomes data frame and a phyla as arguments and returns the average. 

Hint: Remember how `mean()` handles missing data (-1 == missing for our purposes)! 

Hint: the `ifelse()` function might be useful. 

What is the average 16S rRNA gene content for Firmicutes?

#### Bonus

Use the function you wrote in exercise 3 to determine which phyla has the highest average 16S rRNA gene content.

---

#BREAK

---

###<a name="sac"></a><font color='blue'>4. Split-Apply-Combine (plyr)</font>


When we want to analyze data, we often take a split-apply-combine strategy where data is split into manageable pieces which can be operated upon independently, and then combined back together (Wickham 2011).  The `plyr` package combines multiple functions in R to apply this strategy to a dataset.

First let's install the package titled "plyr"

```
install.packages("plyr")
library(plyr)

microbial_genomes = read.table("http://cgs.wustl.edu/~mgibson/swc/microbial_genome.txt", header=T, sep="\t")
head(microbial_genomes)
```

Suppose we want to expand on our previous example of finding the average number of genes per phylum, but for all phyla in the dataset.  We would need to use a split-apply-combine strategy.

First we would split the data independent groups based on phyla:

```
split_phyla<-split(microbial_genomes, microbial_genomes$Phylum)
str(split_phyla)
```

We now have a list of 32 data frames containing all the info from microbial_genomes divided by phylum.  If I want to see all the data related to the first Phylum, Acidobacteria, I can look specifically at that element in the list
  
```  
split_phyla[1]
```

If I wanted to get the mean value of Gene_Count for Acidobacteria, I would have to do the following

```
mean(split_phyla$Acidobacteria$Gene_Count)
```

In our previous example we looked at the average gene count for Actinobacteria and Proteobacteria, but what if we want the mean value for all phyla?  We would need to work with each Phylum individually (Apply step), and then combine them in the same data frame (combine)

```
results<-matrix(nrow=0,ncol=2)
for(i in 1:length(split_phyla)){
	Phylum.name<-names(split_phyla[i])
	mean.gene.count<-mean(split_phyla[[i]]$Gene_Count)
	new.row<-c(Phylum.name, mean.gene.count)
	results<-rbind(results,new.row)
}
head(results)
```

What problems could occur with this?  Are there simplier ways to do this?


The plyr solution.  There are many functions in plyr that can be used to address this problem.  Today we will focus only on ddply.  Let's start with our data frame microbial genomes and try to end up with a dataframe full of mean gene counts for each phylum.

```
?ddply()  #lets discuss some of the split-apply-combine steps integrated in this function
 .data is the dataframe you begin with
 .variables are what you use to SPLIT
 .fun is the function to APPLY
```

and the COMBINE step is an implicit part of the function.

Lets use ddply to generate mean gene counts per phylum:

```
mean_gene_counts<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count)
	
	)
head(mean_gene_counts)
```

We now have all of the gene counts in a data frame with the use of one function.  But what if we want more summary statistics like median, maximum, and minimum values?

```
gene_statistics<-ddply(microbial_genomes, .(Phylum), summarize,
	mean_gene_count=mean(Gene_Count),
	maximum_gene_count=max(Gene_Count),
	minimum_gene_count=min(Gene_Count),
	median_gene_count=median(Gene_Count)
	)
gene_statistics
```


---

###<a name="plotting"></a><font color='blue'>5. Plotting (ggplot)</font>

Another important step in analysis is visualizing your data.  One package that is useful in creating publication quality graphics is ggplot2.  There are several ways to use ggplot2 and there are several tutorials online.  Visit [ggplot2.org](http://ggplot2.org/) for more details and publications related to using ggplot2.

The example we are going to show will illustrate some of the utility of ggplot2 but in no way represents everything you can do with this package.  We will present a straightforward way to display values (mean_gene_count) in relation to categorical variables (Phylum)

Let's start with installing and loading the ggplot2 package

```
install.packages("ggplot2")
library(ggplot2)
```

ggplot2 is based on independent components that can be added to a graph.  Let's start with plotting the mean gene counts of all phylum.

```
ggplot(data=gene_statistics,x=Phylum, y=mean_gene_count)
```

We have the dataset (`data=…`) and variables that we would like to plot, but nothing is produced.  We need geometric objects to represent our data.  In this case we will use points.

```
ggplot(data=gene_statistics)+geom_point(aes(x=Phylum, y=mean_gene_count)) 
```

Now we have added `geom_point()` which is a function that adds points to a plot.  We use `aes()` to pass information to geom_point about which variables we would like to map aesthetically (hence, aes...).  Notice that we can rearrange our code and get the same response.

```
ggplot(data=gene_statistics, aes(x=Phylum,y=mean_gene_count))+geom_point()
```

Now these plots are hard to read due to the x-axis labels running into each other.  With coord_flip() we can rotate our plot, and make it easier to read labels

``` 
ggplot(data=gene_statistics)+geom_point(aes(x=Phylum, y=mean_gene_count))+coord_flip()
```

Whenever we have so many points, it can be difficult to understand trends.  Suppose we wanted to arrange phyla by decreasing mean_gene_count.  We can do this by reordering (`reorder()`) our phyla based on mean_gene_count

```
ggplot(data=gene_statistics)+geom_point(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count))+coord_flip()
```

Now we can see that Tenericutes has the smallest average gene count while Planctomycetes has the highest.  We may also want to establish some sort of uncertainty around our mean value (i.e. standard error).  We can change our points to points with lines representing uncertainty (`geom_pointrange()`)

```
ggplot(data=gene_statistics)+geom_pointrange(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count, ymax=mean_gene_count+standard_error, ymin=mean_gene_count-standard_error))+coord_flip()
```

Suppose this is our final plot that we would like to clean up for publication.  There are several possible options.  Here I will add informative axis labels (`labs(x=...,y=...,title=…)`), get rid of the grey background color and make axis labels black (`theme_bw()`), and make sure that the plot has a square aspect ratio (`theme(aspect.ratio=1)`)

```
ggplot(data=gene_statistics)+geom_pointrange(aes(x=reorder(Phylum, mean_gene_count), y=mean_gene_count, ymax=mean_gene_count+standard_error, ymin=mean_gene_count-standard_error))+coord_flip()+labs(x="Phyla",y="Mean Gene Count", title="Number of Genes in Microbial Genomes")+theme_bw()+theme(aspect.ratio=1)
```

---
###<a name="challenge2"></a><font color='red'>Challenge Exercises</font>

#### Exercise 1.

Write a function to calculate standard error, and then use ddply to calculate the standard error of gene counts for each phylum.  Check the output and discuss any differences/ strange results that you may generate.

#### Exercise 2.

Generate a publication ready bar chart plot of average genome size across phyla with error bars using ddply and ggplot.

#### Exercise 3.

From the microbial_genomes dataframe, generate a publication ready scatterplot showing the correlation of genome size (x) and gene count (y) and color points based on phyla. 
   * Hint:replace phylum with genome size in ggplot and add another argument, `color=…`, to the `aes()` of `geom_point()` (`geom_pointrange(aes(...,color=…)`)

---





