#!/bin/bash
set -ex
# Doubly set, because reasons.
export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/jre

cd /apollo/ && \
	./apollo $APOLLO_TARGET && \
	./apollo $APOLLO_TARGET && \
	# Move to tmp dir
	cp /apollo/target/apollo*.war /tmp/ && \
	# So we can remove ~1.6 GB of cruft from the image. Ignore errors because cannot remove parent dir /apollo/
	rm -rf /apollo/ || true && \
	# Before moving back into a standardized location (that we have write access to)
	mv /tmp/apollo*.war /apollo/ && \
	# Symlink to the expected name, but leave the original to allow us to pull out the named file
	ln -s /apollo/apollo*.war /apollo/apollo.war

if [ -d /output/ ]; then
	cp /apollo/apollo.war /output/;
fi
