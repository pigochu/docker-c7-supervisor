FROM centos:7

ENV container docker

MAINTAINER Pigo Chu <pigochu@gmail.com>


# Install packages
RUN yum install -y epel-release \
&& yum upgrade -y \
&& yum install -y gettext supervisor \
&& yum clean all

# VOLUME
RUN mkdir /docker-settings

VOLUME ["/docker-settings"]

# entrypoint
ENTRYPOINT [ "/opt/c7supervisor/bin/entrypoint.sh" ]
CMD ["supervisord", "-n" , "-c" , "/etc/supervisord.conf"]

# build-files
RUN mkdir -p /opt/c7supervisor/bin
COPY build-files/bin/* /opt/c7supervisor/bin/
RUN chmod 500 /opt/c7supervisor/bin/*
RUN ln -s /opt/c7supervisor/bin/docker-replacefiles.sh /usr/local/bin/docker-replacefiles




