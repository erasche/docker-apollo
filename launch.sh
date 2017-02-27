#!/bin/bash
# https://tomcat.apache.org/tomcat-8.0-doc/config/context.html#Naming
FIXED_CTX=$(echo "${CONTEXT_PATH}" | sed 's|/|#|g')
WAR_FILE=${CATALINA_HOME}/webapps/${FIXED_CTX}.war

cp /apollo.war ${WAR_FILE}
if [ ! -z "$WEBAPOLLO_DB_HOST" ]; then
	until pg_isready -h $WEBAPOLLO_DB_HOST -p $WEBAPOLLO_DB_PORT -U $WEBAPOLLO_DB_USERNAME -d $WEBAPOLLO_DB_NAME; do
		echo "Sleeping on DB"
		sleep 1;
	done;

	until pg_isready -h $WEBAPOLLO_CHADO_DB_HOST -p $WEBAPOLLO_CHADO_DB_PORT -U $WEBAPOLLO_CHADO_DB_USERNAME -d $WEBAPOLLO_CHADO_DB_NAME; do
		echo "Sleeping on Chado DB"
		sleep 1;
	done;
fi


catalina.sh run
