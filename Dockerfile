# WebApollo
# VERSION 2.0
FROM tomcat:7-jre8
MAINTAINER Eric Rasche <esr@tamu.edu>
ENV DEBIAN_FRONTEND noninteractive

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -qq update --fix-missing && \
	apt-get --no-install-recommends -y install \
	git build-essential maven2 libpq-dev postgresql-common \
	postgresql-client xmlstarlet netcat libpng12-dev zlib1g-dev libexpat1-dev \
	ant curl ssl-cert nodejs npm && \
	apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/nodejs /usr/bin/node && \
	npm install -g bower && \
	cp /usr/lib/jvm/java-8-openjdk-amd64/lib/tools.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/ext/tools.jar && \
	useradd -ms /bin/bash -d /apollo apollo

# 2.0.5 + CPT Viral Annotation Additinos
ENV WEBAPOLLO_VERSION f1fb83794581a73aff5a4d02440c43fcd8785470
RUN curl -L https://github.com/erasche/Apollo/archive/${WEBAPOLLO_VERSION}.tar.gz | tar xzf - --strip-components=1 -C /apollo

COPY build.sh /bin/build.sh
ADD apollo-config.groovy /apollo/apollo-config.groovy
ADD annot.json /apollo/annot.json
ADD cpt.css /apollo/cpt.css

RUN chown -R apollo:apollo /apollo
USER apollo
RUN bash /bin/build.sh
USER root

RUN rm -rf ${CATALINA_HOME}/webapps/* && \
	cp /apollo/target/apollo*.war /apollo.war

ENV CONTEXT_PATH ROOT
ADD launch.sh /launch.sh
CMD "/launch.sh"
