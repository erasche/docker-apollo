#!/bin/bash
cp /apollo.war ${CATALINA_HOME}/webapps/${CONTEXT_PATH}.war
catalina.sh run
