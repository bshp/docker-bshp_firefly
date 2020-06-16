FROM ubuntu:focal

MAINTAINER jason.everling@gmail.com

ARG JAVA_HOME
ARG TOMCAT_VERSION
ARG TIMEZONE

ENV JAVA_HOME=$JAVA_HOME
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$PATH:$CATALINA_HOME/bin
ENV TZ=$TIMEZONE

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates

RUN wget \
    --quiet \
    --no-cookies \
    https://downloads.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O /opt/tomcat.tgz && \
    tar xzf /opt/tomcat.tgz -C /opt && \
    mv /opt/apache-tomcat-$TOMCAT_VERSION /opt/tomcat

# Java 8
RUN wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-8-aarch64-linux-jdk.tar.gz -O /opt/java-8-openjdk.tgz && \
    tar xzf /opt/java-8-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-8-openjdk

# Java 11
RUN wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz -O /opt/java-11-openjdk.tgz && \
    tar xzf /opt/java-11-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-11-openjdk

RUN rm /opt/tomcat.tgz && \
    rm /opt/java-11-openjdk.tgz && \
    rm -rf /opt/tomcat/webapps/examples && \
    rm -rf /opt/tomcat/webapps/manager && \
    rm -rf /opt/tomcat/webapps/host-manager && \
    rm -rf /opt/tomcat/webapps/docs && \
    rm -rf /opt/tomcat/webapps/ROOT

COPY opt/tomcat/conf/ /opt/tomcat/conf/
COPY opt/tomcat/webapps/ /opt/tomcat/webapps/
COPY opt/tomcat/entrypoint.sh /opt/entrypoint.sh

EXPOSE 8009

WORKDIR /opt/tomcat

ENTRYPOINT ["/opt/entrypoint.sh"]
