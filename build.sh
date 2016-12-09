#!/bin/bash
set -ex

cd /apollo/ && \
	./apollo deploy && \
	cp /apollo/annot.json /apollo/web-app/jbrowse/plugins/WebApollo/json/annot.json && \
	cp /apollo/annot.json /apollo/jbrowse-download/plugins/WebApollo/json/annot.json && \
	cp /apollo/annot.json /apollo/client/apollo/json/annot.json && \
	./apollo deploy
