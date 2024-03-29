% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/observations.R
\name{save_species}
\alias{save_species}
\title{This function can be called within the observer function to save the full species list.}
\usage{
save_species()
}
\value{
no return value, called for side effects
}
\description{
This function can be called within the observer function to save the full species list.
}
\examples{
\dontrun{
#adding the call to the end_of_timestep_observer function at the config file or object 
#will automatically save all the species at an rds file at the outputfolder/species folder
# and the respective landscape at outputfolder/landscapes for the times steps the observer 
# function is called (i.e. call_observer parameter at the run_simulation function)
save_species()
}
}
\seealso{
\code{\link{save_landscape}}
}
