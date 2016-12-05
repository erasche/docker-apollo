# WebApollo
# VERSION 2.0
FROM tomcat:8
MAINTAINER Eric Rasche <esr@tamu.edu>, Nathan Dunn <nathandunn@lbl.gov>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update --fix-missing && \
    apt-get --no-install-recommends -y install \
    git build-essential maven2 openjdk-7-jdk libpq-dev postgresql-common \
    postgresql-client xmlstarlet netcat libpng12-dev zlib1g-dev libexpat1-dev \
    ant perl5 curl ssl-cert nodejs npm && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g bower && \
    cp /usr/lib/jvm/java-7-openjdk-amd64/lib/tools.jar /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/ext/tools.jar && \
    useradd -ms /bin/bash -d /apollo apollo

# RUN cpan notest install Text::Markdown  # needed for apollo release
# 2.0.4
ENV WEBAPOLLO_VERSION f49142187db46d816a9f874984bee261389756b2
RUN curl -L https://github.com/GMOD/Apollo/archive/${WEBAPOLLO_VERSION}.tar.gz | tar xzf - --strip-components=1 -C /apollo


# RUN cpan notest install Text::Markdown  # needed for apollo release

RUN cd /apollo && \
	./grailsw help && \
	./gradlew help

RUN mv /root/.gradle/ /apollo/.gradle/ && \
	mv /root/.grails/ /apollo/.grails/

COPY build.sh /bin/build.sh
ADD apollo-config.groovy /apollo/apollo-config.groovy
ADD annot.json /apollo/annot.json

RUN chown -R apollo:apollo /apollo
USER apollo
RUN bash /bin/build.sh
USER root

RUN rm -rf ${CATALINA_HOME}/webapps/* && \
    cp /apollo/target/apollo*.war /apollo.war

ENV CONTEXT_PATH ROOT
ADD launch.sh /launch.sh
CMD "/launch.sh"
