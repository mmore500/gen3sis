% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting_functions.R
\name{plot_raster_multiple}
\alias{plot_raster_multiple}
\title{Plot a set of values onto a given landscape}
\usage{
plot_raster_multiple(values, landscape, no_data = 0)
}
\arguments{
\item{values}{a matrix of values with columns corresponding to sets of values, and rows corresponding to grid cells,
this will result in ncol(values) raster plots.}

\item{landscape}{a landscape to plot the values onto}

\item{no_data}{what value should be used for missing data present in the values parameter}
}
\value{
no return value, called for plot
}
\description{
Plot a set of values onto a given landscape
}
