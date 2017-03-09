#!/bin/bash
set -ex

cd /apollo/ && \
	./apollo deploy && \
	cp /apollo/annot.json /apollo/web-app/jbrowse/plugins/WebApollo/json/annot.json && \
	cp /apollo/annot.json /apollo/jbrowse-download/plugins/WebApollo/json/annot.json && \
	cp /apollo/annot.json /apollo/client/apollo/json/annot.json && \
	cp /apollo/AnnotTrack.js /apollo/client/apollo/js/View/Track/AnnotTrack.js && \
	cp /apollo/AnnotTrack.js /apollo/web-app/jbrowse/plugins/WebApollo/js/View/Track/AnnotTrack.js && \
	cp /apollo/AnnotTrack.js /apollo/jbrowse-download/plugins/WebApollo/js/View/Track/AnnotTrack.js && \
	./apollo release
