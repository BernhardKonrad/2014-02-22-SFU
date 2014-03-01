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