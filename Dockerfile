FROM centos:7

ENV container docker

MAINTAINER Pigo Chu <pigochu@gmail.com>


# Install packages
RUN yum install -y epel-release;\
yum upgrade -y;\
yum install -y gettext python-setuptools;\
yum clean all;\
easy_install supervisor;\
echo_supervisord_conf > /etc/supervisord.conf;\
printf "[include]\nfiles=/etc/supervisord.d/*.ini" >> /etc/supervisord.conf;\
mkdir /etc/supervisord.d;chown root:root /etc/supervisord.d;\
mkdir /docker-settings

# VOLUME
VOLUME ["/docker-settings"]

# entrypoint
ENTRYPOINT [ "/opt/c7supervisor/bin/entrypoint.sh" ]
CMD ["supervisord", "-n" , "-c" , "/etc/supervisord.conf"]

# build-files
RUN mkdir -p /opt/c7supervisor/bin
COPY build-files/bin/* /opt/c7supervisor/bin/
RUN chmod 500 /opt/c7supervisor/bin/*;\
ln -s /opt/c7supervisor/bin/docker-replacefiles.sh /usr/local/bin/docker-replacefiles




