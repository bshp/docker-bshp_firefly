#!/bin/bash

if [ "$JAVA_VERSION" == 8 ];then 
    wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-8-aarch64-linux-jdk.tar.gz -O /opt/java-8-openjdk.tgz && \
    tar xzf /opt/java-8-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-8-openjdk && \
    rm /opt/java-8-openjdk.tgz
elif [ "$JAVA_VERSION" == 11 ];then 
    wget \
    --quiet \
    --no-cookies \
    https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz -O /opt/java-11-openjdk.tgz && \
    tar xzf /opt/java-11-openjdk.tgz -C /opt && \
    mv /opt/amazon-corretto-* /opt/java-11-openjdk && \
    rm /opt/java-11-openjdk.tgz
elif [ -z "$JAVA_VERSION" ];then 
    echo "Java version not specified"
    exit 1
else
    echo "Java version not supported, it must be one of 8 or 11, you entered:" $JAVA_VERSION
    exit 1
fi
echo "Installed OpenJDK Version:" $JAVA_VERSION
