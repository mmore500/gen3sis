# Use an R base image
FROM rocker/r-base

# Run commands as root
USER root

# Create the .cloudshell directory, no-apt-get-warning file, update package list,
# install aptitude, additional libraries, Python, pip, and clean up in one RUN command to reduce layers
RUN mkdir -p ~/.cloudshell/ && \
    touch ~/.cloudshell/no-apt-get-warning && \
    apt-get update -y && \
    apt-get install -y aptitude python3 python3-pip git && \
    aptitude install -y libgdal-dev libproj-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install alifedata-phyloinformatics-convert dendropy scipy matplotlib numpy seaborn biopython ete3 phylotrackpy pandas --break-system-packages

# Install R packages with verbose output to diagnose potential installation issues
RUN Rscript -e "options(warn=2); install.packages(c('codetools', 'dplyr', 'gen3sis', 'gdistance', 'ggplot2', 'Matrix', 'raster', 'remotes'), repos='http://cran.rstudio.com/', verbose=TRUE); library(remotes); install_github('cran/rgdal', quiet=FALSE);"
