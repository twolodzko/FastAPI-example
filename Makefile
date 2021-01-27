IMAGE ?= fastapi-demo

.PHONY: run
run: build ## Run the container
	@ docker run -p 8000:8000 -it $(IMAGE)

.PHONY: build
build: ## Build docker image
	docker build -t $(IMAGE) -f Dockerfile .

.PHONY: local
local: ## Run the server outside the container
	@ python app.py

.PHONY: calls
calls: ## Example curl calls to the service
	@ printf "\nBasic call:\n\n"
	curl -v localhost:8000
	@ printf "\n\nHello:\n\n"
	curl -v localhost:8000/hello
	@ printf "\n\nHello Joe:\n\n"
	curl -v localhost:8000/hello/Joe
	@ printf "\n\nRuntime:\n\n"
	curl -v localhost:8000/runtime
	@ printf "\n\nPOST call with data:\n\n"
	curl -X POST localhost:8000/data \
		--header 'Content-Type: application/json' \
		-d '{"timestamp": "2010-01-01 10:00", "name": "foo", "value": "12.5"}'
	@ printf "\n\nUsing invalid timestamp:\n\n"
	curl -X POST localhost:8000/data \
		--header 'Content-Type: application/json' \
		-d '{"timestamp": "invalid", "name": "foo", "value": "12.5"}'
	@ printf "\n\nInvalid address:\n\n"
	curl -v localhost:8000/no-such-address
	@ printf "\n\n"

.PHONY: help
help: ## Display this help
	@ grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'