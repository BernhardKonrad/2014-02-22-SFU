Creating a Reproducible Workflow
================================

1.	Setting up the project directory
------------------------------------

Let's create a project (a reasonably self-contained set of code, data, and
results to answer a discrete scientific question) that will count the animals
sighted in two years of camera trap surveys. We begin by creating a directory
called `camera_analysis` in a convenient place on our hard drive. You might
want to create a main directory called `Projects` or `Research` in your home
folder or in your Documents folder to hold the directories for all of your
individual research projects.

Now, within the `camera_analysis` directory, create four subdirectories:

	.
	├── data
	├── man
	├── results
	├── src

The `data` directory will hold all of the raw data associated with the project,
which in this case will be just a single large csv file containing data on the
animal sightings. The `man` folder, short for manuscript, will (someday)
contain the manuscript that we'll write describing the results of our analysis
(you were planning on using version control for your manuscript too, weren't
you?). The `results` folder will contain the results of our analysis, including
both tables and figures, and the `src` directory will contain all of our code.

For bonus points, do this all from the command line.

2.	Initialize a Git repository
-------------------------------

Since we want to use version control to track the development of our project,
we'll start off right away by initializing an empty Git repository within this
directory. To do this, open a Terminal window, navigate to the main
`camera_analysis` directory, and run the command `git init`.

As you add things to the project directory, and modify old things, you'll want
to frequently commit your changes as we discussed in the Git tutorial.

3.	Add raw data
----------------

Often, we start a project with a particular data file, or set of data files. In
this case, we have the file `sightings_tab_lg.csv`, which contains the records
that we want to analyze. Copy this file from our Github repo into the `data`
subdirectory.

Copy and paste the text below into a `README.txt` file and place it in the data
subdirectory. Remember that this is a bare-bones description - in your own
work, you'll want to include as much information as you have.

	Data received via email on April 1, 2013 from Professor Smith. Includes
	records from camera trap surveys conducted by John Doe and Jane Doe from
	2011-2012. Method of collection, site locations, and additional
	descriptions are found in John Doe's dissertation, Chapter 3 Appendix,
	filed August 2012 at UC Berkeley.

At this point, your project directory should look like this:

	.
	├── data
	│   ├── README.txt
	│   ├── sightings_tab_lg.csv
	├── man
	├── results
	├── src

Add both the data file and readme file to your git repository.

4. Write code to perform analysis
---------------------------------

Now for the real work - writing the code that will perform our analysis. We'd
like to generate two outputs. First, we want to make and save a table that
contains a column with the names of the four mammalian carnivores found in our
data set - Fox, Wolf, Grizzly, and Wolverine - and a second column that
contains the total number of records associated with each species. Second, we'd
like to create and save a simple histogram that shows this result visually.

#### Code

Copy and paste the code from the `functions.r` file from the Github repo.

Note, of course, that this is not the normal workflow for this step. Normally,
you'd spend days/weeks/months working in the `src` directory, writing code, generating results, looking at the results, writing new code,
generating new results, etc. This iterative cycle isn't unlike writing a
paper - you spew out a draft that's not too bad, then go back and revise it,
then spew out some new material, revise that, etc.

Different people have different favorite approaches and tools for this
iterative cycle.

#### The runall script

Now that we have our core functions and tests in place, it's time to create the
"button" for our push-button workflow - the `runall.r` script. The idea is
that you will be able to start with an empty results directory, execute the
line `runall.r` file, and have our table and figure saved in the `results` directory.

Create a new text file called `runall.r` and copy and paste the following code
into it.

```coffee
### Source in required function from the functions file
source("src/functions.r")

### Declare variables
# Set paths to data and results directories
data_dir = 'data/'
results_dir = 'results/'

# Set name of data file, table, and figure
data_name = 'sightings_tab_lg.csv'
table_name = 'spp_table.csv'
fig_name = 'spp_fig.png'

# Set names of species to count
spp_names = c('Fox', 'Wolf', 'Grizzly', 'Wolverine')

### Perform analysis
# Get total number of records for each species
out <- lapply(spp_names, function(x) {
  get_sightings(paste0(data_dir, data_name), x)
})

# Name each output element
names(out) <- spp_names

# Save results as data.frame
library(plyr)
df <- ldply(out, data.frame)
names(df)[1] <- 'species'

# Save data
write.csv(df, "results/spp_table.csv", row.names=FALSE)

### Display results
library(ggplot2)

ggplot(df, aes(species, totalrecs)) +
  geom_bar(stat = "identity") +
  theme_grey(base_size = 18)

ggsave("results/spp_fig.png")
```

This code does just what the comments say that it does. The resulting figure
looks OK, and you would probably want to spend more time adding additional
lines here to adjust the formatting.

Don't forget to add `runall.r` to your git repo.

5. Run the push button analysis
-------------------------------

Now with everything in place, we're ready for the magic. Just for good measure,
delete any files that are hanging around in your `results` directory. Then,
execute `runall.r` and marvel at your fully reproducible workflow! At this point, your directory should look like the below.

	.
	├── data
	│   ├── README.txt
	│   ├── sightings_tab_lg.csv
	├── man
	├── results
	│   ├── spp_table.csv
	│   ├── spp_fig.png
	├── src
	│   ├── functions.r
	│   ├── mean_sightings.r