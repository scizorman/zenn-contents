SHELL := /bin/bash

NPM := npm

markdownlint := $(NPM) run markdownlint --
zenn         := $(NPM) run zenn --

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf node_modules

.PHONY: lint
lint: node_modules
	$(markdownlint) '**/*.md'

.PHONY: fix
fix: node_modules
	$(markdownlint) '**/*.md' --fix

articles/%.md: node_modules
	$(zenn) new:article --slug $*

books/%: node_modules
	$(zenn) new:book --slug $*

.PHONY: preview
preview: node_modules
	$(zenn) preview

node_modules: package.json package-lock.json
	$(NPM) ci
