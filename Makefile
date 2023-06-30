SHELL := /bin/bash

markdownlint := npm run markdownlint --
zenn         := npm run zenn --

all:
	@more $(MAKEFILE_LIST)

clean:
	-rm -rf node_modules

lint: node_modules
	$(markdownlint) '**/*.md'

fix: node_modules
	$(markdownlint) '**/*.md' --fix

articles/%.md: node_modules
	$(zenn) new:article --slug $*

books/%: node_modules
	$(zenn) new:book --slug $*

preview: node_modules
	$(zenn) preview

node_modules: package.json package-lock.json
	npm ci

.PHONY: all clean lint fix preview
