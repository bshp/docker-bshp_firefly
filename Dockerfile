FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ARG JAVA_VERSION
ARG TOMCAT_VERSION
ARG TZ=America/North_Dakota/Center

ENV TOMCAT=$TOMCAT_VERSION
ENV JAVA=$JAVA_VERSION
ENV JAVA_HOME=/opt/java-$JAVA-openjdk
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
    https://repo1.maven.org/maven2/org/apache/tomcat/tomcat/$TOMCAT/tomcat-$TOMCAT.tar.gz -O /opt/tomcat.tgz && \
    tar xzf /opt/tomcat.tgz -C /opt && \
    mv /opt/apache-tomcat-$TOMCAT /opt/tomcat

RUN wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-8-aarch64-linux-jdk.tar.gz -O /opt/java-8-openjdk.tgz && \
    tar xzf /opt/java-8-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-8-openjdk && \
    rm /opt/java-8-openjdk.tgz && \
    wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz -O /opt/java-11-openjdk.tgz && \
    tar xzf /opt/java-11-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-11-openjdk && \
    rm /opt/java-11-openjdk.tgz && \
    echo "Using Tomcat Version:" $TOMCAT "with JAVA_HOME set to:" $JAVA_HOME

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
