#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM yaronr/openjdk-7-jre

ENV ES_PKG_NAME elasticsearch-1.4.0

# Install ElasticSearch.
RUN \
  cd / && \
  wget --progress=bar:force --retry-connrefused -t 5 https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Install Plugins.
RUN \
  /elasticsearch/bin/plugin --install mobz/elasticsearch-head && \
  /elasticsearch/bin/plugin --install lukas-vlcek/bigdesk

# Define working directory.
WORKDIR /data

ENTRYPOINT ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
