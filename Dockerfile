FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ARG JAVA_VERSION
ARG TOMCAT_VERSION
ARG TZ=America/North_Dakota/Center

# Uncomment if used, also uncomment the Landscape RUN section
#ARG LANDSCAPE_TOKEN=Landscape_Join_Password
#ARG LANDSCAPE_URL=https://landscape.example.com

ENV TOMCAT=$TOMCAT_VERSION
ENV JAVA=$JAVA_VERSION
ENV JAVA_HOME=/opt/java-$JAVA-openjdk
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$PATH:$CATALINA_HOME/bin:$JAVA_HOME/bin

RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    libapache2-mod-jk \
    wget && \
    service apache2 stop

# Landscape, Ensure you also uncomment the args and adjust
#COPY bin/landscape.sh /opt/landscape.sh
#RUN apt update && \
#    apt-get install -y --no-install-recommends \
#    landscape-client && \
#    chmod 0755 /opt/landscape.sh && /opt/landscape.sh

RUN wget \
    --quiet \
    --no-cookies \
    https://repo1.maven.org/maven2/org/apache/tomcat/tomcat/${TOMCAT}/tomcat-${TOMCAT}.tar.gz -O /opt/tomcat.tgz && \
    tar xzf /opt/tomcat.tgz -C /opt && \
    mv /opt/apache-tomcat-${TOMCAT} /opt/tomcat

# Install Java
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

RUN echo "Using Tomcat Version:" ${TOMCAT} "with JAVA_HOME set to:" ${JAVA_HOME}

EXPOSE 80 443

WORKDIR /opt/tomcat

VOLUME ["/opt/tomcat/logs"]
VOLUME ["/var/log"]

ENTRYPOINT ["/opt/entrypoint.sh"]
