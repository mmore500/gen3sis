# Use an R base image
FROM rocker/r-base

# Run commands as root
USER root

# Create the .cloudshell directory and no-apt-get-warning file
RUN mkdir -p ~/.cloudshell/ && \
    touch ~/.cloudshell/no-apt-get-warning

# Update the package list
RUN apt-get update -y && \
    # Install aptitude
    apt-get install -y aptitude && \
    # Install additional libraries
    aptitude install -y libgdal-dev libproj-dev

# Install R packages
RUN Rscript -e "install.packages(c('codetools', 'dplyr', 'gen3sis', 'gdistance', 'ggplot2', 'Matrix', 'raster', 'rgdal'))"
