build:
	docker build -t apollo .

run:
	docker-compose kill
	docker-compose rm -f apollo
	docker-compose up
