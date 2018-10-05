FROM centos:7

ENV container docker

MAINTAINER Pigo Chu <pigochu@gmail.com>


# Install packages
RUN yum install -y epel-release;\
yum upgrade -y;\
yum install -y gettext python-setuptools;\
yum clean all;\
easy_install supervisor;\
mkdir /etc/supervisord.d;\
mkdir /var/log/supervisor;\
mkdir /var/run/supervisor;\
mkdir /docker-settings;\
mkdir -p /opt/c7supervisor/bin

# VOLUME
VOLUME ["/docker-settings"]

# entrypoint
ENTRYPOINT [ "/opt/c7supervisor/bin/entrypoint.sh" ]
CMD ["supervisord", "-n" , "-c" , "/etc/supervisord.conf"]

# build-files
COPY build-files/bin/* /opt/c7supervisor/bin/
COPY build-files/etc/supervisord.conf /etc/
RUN chmod 500 /opt/c7supervisor/bin/*;\
chmod 600 /etc/supervisord.conf;\
ln -s /opt/c7supervisor/bin/docker-replacefiles.sh /usr/local/bin/docker-replacefiles




