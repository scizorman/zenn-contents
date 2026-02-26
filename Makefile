.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: lint
lint:
	markdownlint-cli2 '**/*.md'

.PHONY: fmt
fmt:
	markdownlint-cli2 '**/*.md' --fix

articles/%.md:
	zenn new:article --slug $*

books/%:
	zenn new:book --slug $*

.PHONY: preview
preview:
	zenn preview
