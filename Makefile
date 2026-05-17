# Declare non-file targets
.PHONY: default help build run site css site-watch css-watch tailscale clean post post-folder short banner

# Configuration variables
log ?= warn          # debug|info|warn|error
env ?= development   # development|production
drafts ?= true       # true|false

help:		## List all available commands with descriptions
	@awk -F'##' '/^[a-zA-Z0-9_-]+:.*##/ {gsub(/:.*/, ":\t\t", $$1); printf "%s%s\n", $$1, $$2}' $(MAKEFILE_LIST) | \
		awk 'NR%2==1 {print "\033[0m" $$0} NR%2==0 {print "\033[2m" $$0}'
	@echo "\033[0m"

default: run

build: css site ## Build Tailwind and Hugo, but don't start server

run: ## Build and run Tailwind and Hugo
	@make -j2 css-run site-run

site:		## Build Hugo site (one-time)
	@echo "=================================="
	@echo "Building Hugo site..."
	@echo "=================================="
	@hugo build \
		--cleanDestinationDir --gc --minify --printI18nWarnings \
		$(if $(filter false,$(drafts)),,--buildDrafts) \
		--logLevel $(log) \
		--environment $(env)

css:		## Compile Tailwind CSS (one-time)
	@echo "=================================="
	@echo "Compiling Tailwind css..."
	@echo "=================================="

	@npx @tailwindcss/cli \
		-i ./assets/css/input.css \
		-o ./assets/css/output.css

site-run:
	@echo "=================================="
	@echo "Building and running Hugo site..."
	@echo "=================================="
	@make site
	@hugo server

css-run:
	@echo "=================================="
	@echo "Building and running Tailwind css..."
	@echo "=================================="
	@npx @tailwindcss/cli \
		-i ./assets/css/input.css  \
		-o ./assets/css/output.css \
		--watch
