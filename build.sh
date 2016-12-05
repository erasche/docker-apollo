cd /apollo/ && \
	./gradlew :setup-jbrowse && \
	cp /apollo/annot.json /apollo/web-app/jbrowse/plugins/WebApollo/json/annot.json && \
	./apollo clean-all && ./apollo deploy
