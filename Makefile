build:
	docker build -t apollo .

run:
	docker-compose kill
	docker-compose rm apollo
	docker-compose up
