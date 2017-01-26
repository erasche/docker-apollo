#!/bin/bash
# https://tomcat.apache.org/tomcat-8.0-doc/config/context.html#Naming
FIXED_CTX=$(echo "${CONTEXT_PATH}" | sed 's|/|#|g')
WAR_FILE=${CATALINA_HOME}/webapps/${FIXED_CTX}.war

cp /apollo.war ${WAR_FILE}
catalina.sh run
