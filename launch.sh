#!/bin/sh
# https://tomcat.apache.org/tomcat-8.0-doc/config/context.html#Naming
FIXED_CTX=$(echo "${CONTEXT_PATH}" | sed 's|/|#|g')
WAR_FILE=${CATALINA_HOME}/webapps/${FIXED_CTX}.war

rm -rf ${CATALINA_HOME}/webapps/*

cp /apollo/apollo.war ${WAR_FILE}
if [ ! -z "$WEBAPOLLO_DB_HOST" ]; then
	export PGUSER=$WEBAPOLLO_DB_USERNAME
	export PGPASSWORD=$WEBAPOLLO_DB_PASSWORD
	export DB_CONNECT=$(echo $WEBAPOLLO_DB_URI | sed 's/jdbc://g')
	while ! psql $DB_CONNECT -l; do
		echo "Sleeping on DB"
		sleep 1;
	done;

	export PGUSER=$WEBAPOLLO_CHADO_DB_USERNAME
	export PGPASSWORD=$WEBAPOLLO_CHADO_DB_PASSWORD
	export DB_CONNECT=$(echo $WEBAPOLLO_CHADO_DB_URI | sed 's/jdbc://g')
	while ! psql $DB_CONNECT -l; do
		echo "Sleeping on Chado DB"
		sleep 1;
	done;
fi


catalina.sh run
