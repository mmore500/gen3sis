% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{plot_ranges}
\alias{plot_ranges}
\title{Plot species ranges of the given list of species on a landscape}
\usage{
plot_ranges(species_list, landscape, disturb = 0, max_sps = 10)
}
\arguments{
\item{species_list}{a list of species to use in the richness calculation}

\item{landscape}{a corresponding landscape object}

\item{disturb}{value randomly added to shift each species symbol. Useful to enhance visualization in case of multiple species overlaps}

\item{max_sps}{maximum number of plotted species, not recommended above 20}
}
\value{
no return value, called for plot
}
\description{
Plot species ranges of the given list of species on a landscape
}
\examples{
## plot from saved outputs
# get path containing outputs
datapath <- system.file(file.path("extdata", "WorldCenter"), package="gen3sis")
# get species at t0
species_t_50 <- readRDS(file.path(datapath,
                        "output/config_worldcenter/species/species_t_50.rds"))
# get landscape at t0
landscape_t_50 <- readRDS(file.path(datapath,
                          "output/config_worldcenter/landscapes/landscape_t_50.rds"))
# plot range
plot_ranges(species_t_50, landscape_t_50)

# get species at t0
species_t_25 <- readRDS(file.path(datapath, 
                        "output/config_worldcenter/species/species_t_25.rds"))
# get landscape at t0
landscape_t_25 <- readRDS(file.path(datapath, 
                        "output/config_worldcenter/landscapes/landscape_t_25.rds"))
# plot ranges at intermediate time-step
plot_ranges(species_t_25, landscape_t_25, disturb = 2, max_sps = 20)

## plot from within observer
# call plot_richness from inside the end_of_timestep_observer function 
# at the config file:
\dontrun{
plot_ranges(data$all_species, data$landscape)
} 
}
