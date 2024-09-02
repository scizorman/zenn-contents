.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf node_modules

markdownlint := node_modules/.bin/markdownlint-cli2
zenn         := node_modules/.bin/zenn
$(markdownlint) $(zenn): node_modules
node_modules: package.json bun.lockb .bun-version
	bun install --frozen-lockfile
	touch $@

.PHONY: lint
lint: $(markdownlint)
	$< '**/*.md'

.PHONY: fmt
fmt: $(markdownlint)
	$< '**/*.md' --fix

articles/%.md: | $(zenn)
	$< new:article --slug $*

books/%: | $(zenn)
	$< new:book --slug $*

.PHONY: preview
preview: $(zenn)
	$< preview
