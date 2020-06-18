#!/bin/bash

if [ "$JAVA_VERSION" == 8 ];then 
    wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-8-aarch64-linux-jdk.tar.gz -O /opt/java-8-openjdk.tgz && \
    tar xzf /opt/java-8-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-8-openjdk && \
    rm /opt/java-8-openjdk.tgz
else 
    wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz -O /opt/java-11-openjdk.tgz && \
    tar xzf /opt/java-11-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-11-openjdk && \
    rm /opt/java-11-openjdk.tgz
fi
echo "Installed OpenJDK Version:" $JAVA_VERSION
