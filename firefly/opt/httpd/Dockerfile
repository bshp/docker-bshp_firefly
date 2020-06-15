FROM ubuntu:bionic

MAINTAINER jason.everling@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends apache2 ca-certificates libapache2-mod-jk && service apache2 stop

RUN mkdir /opt/ssl && chown -R www-data:www-data /opt/ssl

COPY opt/httpd/etc/apache2/ /etc/apache2/
COPY opt/httpd/etc/libapache2-mod-jk/ /etc/libapache2-mod-jk/
COPY etc/ssl/ /etc/ssl/

RUN a2enmod rewrite
RUN a2enmod ssl

VOLUME ["/var/log/apache2"]

EXPOSE 80 443

CMD ["apachectl", "-k", "start", "-DFOREGROUND"]
