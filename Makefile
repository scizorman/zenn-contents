.DELETE_ON_ERROR:

SHELL := /bin/bash

NPM := npm

node_modules := node_modules
markdownlint := $(node_modules)/.bin/markdownlint-cli2
zenn         := $(node_modules)/.bin/zenn

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf $(node_modules)

$(markdownlint) $(zenn): $(node_modules)
$(node_modules): package.json package-lock.json
	$(NPM) ci

.PHONY: lint
lint: $(markdownlint)
	$< '**/*.md'

.PHONY: fix
fix: $(markdownlint)
	$< '**/*.md' --fix

articles/%.md: $(zenn)
	$< new:article --slug $*

books/%: $(zenn)
	$< new:book --slug $*

.PHONY: preview
preview: $(zenn)
	$< preview
