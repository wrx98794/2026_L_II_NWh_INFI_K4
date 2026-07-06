deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	PYTHONPATH=. pytest --verbose -s

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run --name hello-world-printer-dev -p 5000:5000 -d hello-world-printer

docker_push:
	@echo "Logowanie do Docker Hub..."
	echo "$$DOCKER_PASSWORD" | docker login -u "$$DOCKER_USERNAME" --password-stdin
	@echo "Tagowanie obrazu..."
	docker tag hello-world-printer wrx98794/hello-world-printer:latest
	@echo "Pushowanie obrazu..."
	docker push wrx98794/hello-world-printer:latest