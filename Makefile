SHELL := /bin/bash

zenn := npm run zenn --

all:
	@more $(MAKEFILE_LIST)

clean:
	-rm -rf node_modules

lint fmt: node_modules
	npm run $@

articles/%.md: node_modules
	$(zenn) new:article --slug $*

books/%: node_modules
	$(zenn) new:book --slug $*

preview: node_modules
	$(zenn) preview

node_modules: package.json package-lock.json
	npm ci

.PHONY: all clean lint fmt preview
