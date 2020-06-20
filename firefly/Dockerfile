FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ARG JAVA_VERSION
ARG TOMCAT_VERSION
ARG TZ=America/North_Dakota/Center

ENV JAVA_HOME=/opt/java-$JAVA_VERSION-openjdk
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$PATH:$CATALINA_HOME/bin:$JAVA_HOME/bin

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    libapache2-mod-jk \
    wget && \
    service apache2 stop

RUN wget \
    --quiet \
    --no-cookies \
    https://downloads.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O /opt/tomcat.tgz && \
    tar xzf /opt/tomcat.tgz -C /opt && \
    mv /opt/apache-tomcat-$TOMCAT_VERSION /opt/tomcat

COPY bin/setjava.sh /opt/setjava.sh

RUN chmod 0755 /opt/setjava.sh && /opt/setjava.sh

RUN rm /opt/tomcat.tgz && \
    rm -rf /opt/tomcat/webapps/examples && \
    rm -rf /opt/tomcat/webapps/manager && \
    rm -rf /opt/tomcat/webapps/host-manager && \
    rm -rf /opt/tomcat/webapps/docs && \
    rm -rf /opt/tomcat/webapps/ROOT

COPY bin/entrypoint.sh /opt/entrypoint.sh
COPY etc/apache2/ /etc/apache2/
COPY etc/libapache2-mod-jk/ /etc/libapache2-mod-jk/
COPY etc/ssl/ /etc/ssl/
COPY opt/tomcat/conf/ /opt/tomcat/conf/
COPY opt/tomcat/webapps/ /opt/tomcat/webapps/

RUN a2enmod rewrite ssl

EXPOSE 80 443

WORKDIR /opt/tomcat

VOLUME ["/opt/tomcat/logs"]
VOLUME ["/var/log"]

ENTRYPOINT ["/opt/entrypoint.sh"]
