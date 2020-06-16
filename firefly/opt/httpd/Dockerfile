FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ENV TZ=America/North_Dakota/Center

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    libapache2-mod-jk && \
    service apache2 stop

COPY opt/httpd/etc/apache2/ /etc/apache2/
COPY opt/httpd/etc/libapache2-mod-jk/ /etc/libapache2-mod-jk/
COPY etc/ssl/ /etc/ssl/

RUN a2enmod rewrite ssl

VOLUME ["/var/log/apache2"]

EXPOSE 80 443

CMD ["apachectl", "-k", "start", "-DFOREGROUND"]
