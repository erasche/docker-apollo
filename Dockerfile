# WebApollo
# VERSION 2.0
FROM tomcat:8-jre8
MAINTAINER Eric Rasche <esr@tamu.edu>
ENV DEBIAN_FRONTEND noninteractive

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -qq update --fix-missing && \
	apt-get --no-install-recommends -y install \
	git build-essential maven2 libpq-dev postgresql-common openjdk-8-jdk \
	postgresql-client xmlstarlet netcat libpng12-dev zlib1g-dev libexpat1-dev \
	ant curl ssl-cert nodejs && \
	apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g bower && \
	cp /usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/tools.jar && \
	useradd -ms /bin/bash -d /apollo apollo

# 2.0.6+ with CPT Viral Annotation Additinos
ENV WEBAPOLLO_VERSION d9894f2602029b0c2b461d5a33e5ecff8686d182
RUN curl -L https://github.com/erasche/Apollo/archive/${WEBAPOLLO_VERSION}.tar.gz | tar xzf - --strip-components=1 -C /apollo

COPY build.sh /bin/build.sh
ADD apollo-config.groovy /apollo/apollo-config.groovy
ADD annot.json /apollo/annot.json
ADD AnnotTrack.js /apollo/AnnotTrack.js
ADD cpt.css /apollo/cpt.css

RUN chown -R apollo:apollo /apollo
USER apollo
RUN bash /bin/build.sh
USER root

ENV CONTEXT_PATH ROOT
ADD launch.sh /launch.sh
CMD "/launch.sh"
