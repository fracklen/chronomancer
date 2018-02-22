.PHONY: test deploy

## Docker variables
IMAGE_NAME := chronomancer
SRC_FOLDER := .

test: docker_test_build docker_test

docker-build:
	docker build -t chronomancer .

docker_test:
	docker-compose \
	    -f "docker-compose-test.yml" \
	    -p "chronomancer_$(git rev-parse --short HEAD)" \
	    run --rm "runner" make test_in_docker

test_in_docker:
	cp config/database.docker_test.yml config/database.yml
	scripts/wait-for-it.sh db:5432 -s -t 120 -- echo "Postgres Up and running!"
	RAILS_ENV=test bundle exec rake db:create db:migrate
	RAILS_ENV=test bundle exec rspec spec

docker_test_build:
	docker build -t chronomancer_test -f Dockerfile.test .

docker-push-image:
	docker tag chronomancer $(DOCKER_REPO)/chronomancer:latest
	docker push $(DOCKER_REPO)/chronomancer:latest

docker-clean:
	docker-compose \
		-p "chronomancer_$(git rev-parse --short HEAD)" \
	    -f docker-compose-test.yml down

deploy: docker-build docker-push-image
