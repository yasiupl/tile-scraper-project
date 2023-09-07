help: ## Print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy: clone install scrape serve ## First run - run all of the below...

clone: ## Clone submodule repositories
	git submodule init
	git submodule update

install: ## Install python dependencies.
	cd tile-scraper
	pip install -r requirements.txt

scrape: ## Run default scrape script.
	./scrape.sh

serve: ## Run development server.
	./serve.py