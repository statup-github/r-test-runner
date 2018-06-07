FROM rocker/r-ver:latest
MAINTAINER Stefan Fritsch <stefan.fritsch@stat-up.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install --no-install-recommends -yq \
       zlib1g-dev libssl-dev libcurl4-openssl-dev \
       texlive libssh2-1-dev

RUN rm -rf /tmp/* \
  && apt-get remove --purge -y $BUILDDEPS \
  && apt-get autoremove -y \
  && apt-get autoclean -y \
  && rm -rf /var/lib/apt/lists/*

RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \ 
	&& echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen
RUN update-locale

RUN Rscript -e 'install.packages("devtools")'

CMD ["R"]