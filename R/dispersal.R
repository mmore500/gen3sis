# Copyright (c) 2020, ETH Zurich

#' Allows the user to generate dispersal value(s) for a given species. The simulation request the user 
#' to return a vector of dispersal values with length specified by the num_draws parameter
#'
#' @details Dispersal values are used for two different operations. 
#' First, for colonization, dispersal values are used to evaluate pairwise dispersal
#' events between colonized and uninhabited sites. 
#' Second, for geographic clustering, dispersal values are used during the clustering of
#' species populations when determining which sites 
#' are in range of each other and belong to the same geographic cluster.
#' 
#' num_draws tells the user how many dispersal values are requested by the simulation when this function is called and must 
#' be returned. It can be of varying length depending on the operation calling it, i.e. colonization or geographic clustering. 
#' If the dispersal is considered as fixed the function should return a vector of length num_draws with repeated identical
#' values, or varying values in case of more complex dispersal kernels.
#' 
#' Note: if the distances are randomized the cluster formation may be asymmetrical. Therefore the ordering of all
#' clustering operations is randomized.
#' 
#' @param num_draws the number of dispersal values drawn
#' @param species the species for which the values are to be produced
#' @param landscape the landscape of the current time step
#' @param config the config of the simulation
#'
#' @return a numerical vector of length num_draws with dispersal values
#' @export
get_dispersal_values <- function(num_draws, species, landscape, config) {
  stop("this function documents the user function interface only, do not use it")
}

#' The top level loop for dispersal
#'
#' @details orchestrates the dispersal of all species.
#' This is a per species process that looks at every species individually
#'
#' @param config config object
#' @param data general data container
#' @param vars general variables container
#'
#' @return returns the standard val(config, data, vars) list
#' @noRd
loop_dispersal <- function(config, data, vars){
  if(config$gen3sis$general$verbose>=3){
    cat(paste("entering dispersal module \n"))
  }

  data$all_species <- lapply(data$all_species, disperse, data$landscape, data$distance_matrix, config)

  if(config$gen3sis$general$verbose>=3){
    cat(paste("exiting dispersal module \n"))
  }
  return(list(config = config, data = data, vars = vars))
}


#' Disperses a given species
#'
#' @details This function selects all suitable sites from the landscape and checks whether the given
#' species can reach and colonize any one of them
#'
#' @param species the species to apply dispersal to
#' @param landscape the landscape of the current time-step
#' @param distance_matrix the distance matrix between sites to check the dispersal capabilities against
#' @param config the config of the simulation
#'
#' @return the dispersed species object
#' @noRd
disperse <- function(species, landscape, distance_matrix, config){
  if ( !length(species[["abundance"]]) ) {
    return(species)
  }

  presence_spi_ti <- names(species[["abundance"]])

  all_cells <- rownames(landscape$coordinates)
  free_cells <- all_cells[!(all_cells %in% presence_spi_ti)]
  num_draws <- length(free_cells) * length(presence_spi_ti)

  r_disp <- config$gen3sis$dispersal$get_dispersal_values(num_draws, species, landscape, config)

  geo_disp <- distance_matrix[presence_spi_ti, free_cells, drop=FALSE] #lines mark where they are present, cols the possible suitable sites
  geo_disp <- geo_disp <= r_disp

  colonized <- rep(FALSE, length(all_cells))
  names(colonized) <- all_cells
  colonized[free_cells] <- apply(geo_disp, 2, any)

  tep_occ_id <- all_cells[colonized]
  if ( length( tep_occ_id ) > 0 ) { # if there are new occurrences....
    # destiny of genes
    dest <- which(colonized==TRUE)
    # origin of genes
    if ( length(presence_spi_ti)==1 ){
      orig <- rep(1,length(dest))
    } else {
      orig <- apply(geo_disp[, colonized[free_cells], drop=FALSE], 2,
                    function(x){ a <- which(x); ifelse( length(a) > 1, sample( a, 1), a)})
    }
    orig <- as.numeric(presence_spi_ti[orig])
    dest <- tep_occ_id

    species <- disperse_species(species, as.character(orig), dest, config)
  }
  return(species)
}
