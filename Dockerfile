FROM centos:7

ENV container docker

MAINTAINER Pigo Chu <pigochu@gmail.com>


# Install packages
RUN yum install -y epel-release
RUN yum upgrade -y
RUN yum install -y gettext supervisor
RUN yum clean all


# VOLUME
RUN mkdir /docker-settings

VOLUME ["/docker-settings"]

# build-files
RUN mkdir -p /opt/c7supervisor/bin
COPY build-files/bin/* /opt/c7supervisor/bin
RUN chmod 500 /opt/c7supervisor/bin/*
COPY build-files/templates/supervisor.conf /etc/supervisor.conf
RUN ln -s /usr/local/bin/docker-replacefiles /opt/c7supervisor/bin/docker-replacefiles.sh


# entrypoint
ENTRYPOINT ["/opt/c7supervisor/bin/entrypoint.sh"]






