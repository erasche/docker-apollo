# WebApollo
# VERSION 2.0
FROM tomcat:8.5-jre8-alpine

COPY build.sh /bin/build.sh
ADD apollo-config.groovy /apollo/apollo-config.groovy
ENV WEBAPOLLO_VERSION b67f41739467a11dbec410f592af4460b767f56e

RUN apk update && \
	apk add --update tar && \
	apk add curl ca-certificates bash nodejs git postgresql-client maven libpng \
		make g++ zlib-dev expat-dev nodejs-npm sudo && \
	npm install -g bower && \
	adduser -s /bin/bash -D -h /apollo apollo && \
	curl -L https://github.com/GMOD/Apollo/archive/${WEBAPOLLO_VERSION}.tar.gz | \
	tar xzf - --strip-components=1 -C /apollo && \
	chown -R apollo:apollo /apollo && \
	apk add openjdk8 openjdk8-jre && \
	cp /usr/lib/jvm/java-1.8-openjdk/lib/tools.jar /usr/lib/jvm/java-1.8-openjdk/jre/lib/ext/tools.jar && \
	sudo -u apollo /bin/build.sh && \
	apk del curl bash nodejs git libpng make g++ nodejs-npm openjdk8 sudo

ENV CONTEXT_PATH ROOT
ADD launch.sh /launch.sh
CMD "/launch.sh"
