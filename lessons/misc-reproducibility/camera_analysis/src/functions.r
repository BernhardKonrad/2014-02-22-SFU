# Module containing functions to calculate mean number of sightings of a given animal in a given sightings csv file.

## Functions
## get_sightings - get number of sightings of focus animal in data set

#' Get number of sightings of a focus animal in a data set.
#' 
#' @param filename (character) Path to file containing sightings data
#' @param focusanimal (character) Name of focus animal (not case sensitive)
#' 
#' @return data.frame containing total count of number of focus animal seen and 
#' mean count of individuals per sighting event.
#' 
#' @note Data file must be csv format with Animal and Count columns containing
#' animal name and count of individuals per sighting, respectively.
#' 
#' @examples
#' # An example with one name
#' filename = "data/sightings_tab_lg.csv"
#' focusanimal = "Elk"
#' get_sightings(filename, focusanimal)

get_sightings <- function(filename, focusanimal){
  # Load table
  tab <- read.csv(filename)
  
  # Find number of records and total count of animals seen
  isfocus <- tab[ tab$Animal == focusanimal, ]
  totalrecs <- sum(isfocus$Count)
  
  if (totalrecs == 0){
    meancount = 0
  } else {
    meancount = mean(isfocus$Count)
  }
  
  # Return num of records and animals seen
  return( list(totalrecs=totalrecs, meancount=meancount) )
}
