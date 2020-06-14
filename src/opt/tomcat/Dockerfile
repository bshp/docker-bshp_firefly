FROM ubuntu:bionic

MAINTAINER jason.everling@gmail.com

ARG JAVA_HOME
ARG TOMCAT_VERSION

ENV JAVA_HOME=$JAVA_HOME

RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates

RUN wget --quiet --no-cookies https://downloads.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz -O /opt/tomcat.tgz && \
tar xzf /opt/tomcat.tgz -C /opt && mv /opt/apache-tomcat-$TOMCAT_VERSION /opt/tomcat

RUN wget --quiet --no-cookies https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz -O /opt/java-11-openjdk.tgz && \
tar xzf /opt/java-11-openjdk.tgz -C /opt && mv /opt/amazon-corretto-* /opt/java-11-openjdk

RUN rm /opt/tomcat.tgz && rm /opt/java-11-openjdk.tgz && rm -rf /opt/tomcat/webapps/examples && rm -rf /opt/tomcat/webapps/manager && rm -rf /opt/tomcat/webapps/host-manager && rm -rf /opt/tomcat/webapps/docs

COPY /conf/ /opt/tomcat/conf/
COPY /webapps/ /opt/tomcat/webapps/
COPY entrypoint.sh /opt/entrypoint.sh

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8009

WORKDIR /opt/tomcat

ENTRYPOINT ["/opt/entrypoint.sh"]
