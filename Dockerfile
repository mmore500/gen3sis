# Use an R base image
FROM rocker/r-base

# Run commands as root
USER root

# Create the .cloudshell directory, no-apt-get-warning file, update package list,
# install aptitude, additional libraries, and clean up in one RUN command to reduce layers
RUN mkdir -p ~/.cloudshell/ && \
    touch ~/.cloudshell/no-apt-get-warning && \
    apt-get update -y && \
    apt-get install -y aptitude && \
    aptitude install -y libgdal-dev libproj-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install R packages
RUN Rscript -e "install.packages(c('codetools', 'dplyr', 'gen3sis', 'gdistance', 'ggplot2', 'Matrix', 'raster', 'rgdal'))"
