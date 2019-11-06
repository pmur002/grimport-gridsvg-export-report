
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    r-base=3.6* \ 
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'

# Packages used in the report
RUN Rscript -e 'library(devtools); install_version("gridSVG", "1.7-1", repos="https://cran.rstudio.com/")'
RUN apt-get update && apt-get install -y \
    librsvg2-dev
RUN Rscript -e 'library(devtools); install_version("rsvg", "1.3", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("ggplot2", "3.0.0", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("cowplot", "0.9.3", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("png", "0.1-7", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("jpeg", "0.1-8", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("base64enc", "0.1-3", repos="https://cran.rstudio.com/")'

# Using COPY will update (invalidate cache) if the tar ball has been modified!
COPY grImport2_0.2-0.tar.gz /tmp/
RUN R CMD INSTALL /tmp/grImport2_0.2-0.tar.gz


