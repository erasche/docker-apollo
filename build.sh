cd /apollo/ && \
	./gradlew :setup-jbrowse && \
	./apollo clean-all && \
	cp /apollo/annot.json /apollo/web-app/jbrowse/plugins/WebApollo/json/annot.json && \
	./apollo deploy
