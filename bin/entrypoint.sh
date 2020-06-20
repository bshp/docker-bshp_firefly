#!/bin/sh

service apache2 start && \
$CATALINA_HOME/bin/catalina.sh run
