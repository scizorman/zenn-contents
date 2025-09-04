.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf node_modules

markdownlint := mise exec npm:markdownlint-cli2 -- markdownlint-cli2
zenn := mise exec npm:zenn-cli -- zenn
.PHONY: lint
lint:
	$(markdownlint) '**/*.md'

.PHONY: fmt
fmt:
	$(markdownlint) '**/*.md' --fix

articles/%.md:
	$(zenn) new:article --slug $*

books/%:
	$(zenn) new:book --slug $*

.PHONY: preview
preview:
	$(zenn) preview
