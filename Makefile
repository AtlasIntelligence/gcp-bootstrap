.PHONY: start check-env prepare #clean init plan lint format apply check-security

CURRENT_DIRECTORY := $(shell pwd)
END_USER_EMAIL=""
ORGANIZATION_ID=""
BILLING_ACCOUNT_ID=""
PROJECT := $(shell gcloud config get-value project)
NOW := $(shell date +"%F")

OUT_DIR := scripts modules

MKDIR_P = mkdir -p
TF = terraform
TF_DIR := environments
ENV="stage"
REGION="europe-west3"
S3_BUCKET="gs://$(ENV)-tfstate-$(NOW)"

BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput -T ansi sgr0)

all:
	@echo "All done"

start: ## Validate requirements
	@echo "Validate tools and requirements"
	@sh scripts/requirements.sh -o $(ORGANIZATION_ID) -b $(BILLING_ACCOUNT_ID) -u $(END_USER_EMAIL)

directories: ${OUT_DIR} ## Create init directory
${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}

check-env: ## Check Variables
	@if [ -z $(ENV) ]; then \
		echo "$(BOLD)$(RED)set variable ENV and try again $(RESET)"; \
		echo "$(BOLD)Example usage: \`ENV=stage make plan\`$(RESET)"; \
		exit 1; \
	 fi
	@if [ -z $(REGION) ]; then \
		echo "$(BOLD)$(RED)Resource Location was not set$(RESET)"; \
		echo "$(BOLD)Example usage: \`ENV=stage REGION=europe-west3 make plan\`$(RESET)"; \
		exit 1; \
	 fi

# Todo: change storageclass to nearline for cost optimisation
# Todo: Enable encryption for bucket using --decryption-keys
prepare: start check-env ## Prepare a new environment, configure the remote tfstate backend
	@echo "$(BOLD)Check that the S3 bucket $(S3_BUCKET) for remote state exists$(RESET)"
	@if ! $(PROJECT) > /dev/null 2>&1 ; then \
		echo "$(BOLD)You are connected using project $(GREEN)$(PROJECT)$(RESET)"; \
	else \
		echo "$(BOLD)You are not connected on any gcp project, Please ligon and try again $(GREEN)$(PROJECT)$(RESET)"; \
	fi

	@if ! gcloud alpha storage ls $(S3_BUCKET) > /dev/null 2>&1 ; then \
		echo "$(BOLD)S3 bucket $(S3_BUCKET) was not found, $(YELLOW)Creating new bucket to store tfstate file with versioning, encryption enabled and block public access $(RESET)"; \
		gcloud alpha storage buckets create $(S3_BUCKET) \
			--project=$(PROJECT) \
			--location=$(REGION) \
			--billing-project=$(PROJECT) \
			--storage-class=STANDARD \
			--uniform-bucket-level-access; \
		@sleep 0.5; \
		gsutil versioning set on $(S3_BUCKET); \
	else \
		echo "$(BOLD)$(GREEN)S3 bucket $(S3_BUCKET) is use $(RESET)"; \
	fi
	@echo "$(BOLD)$(GREEN)Remote Backend State Initialisation Complet!.."

clean: ## Clean the folder.
	@cd "$(TF_DIR)"/$(ENV) && rm -fR .terraform*

init:
	@cd "$(TF_DIR)"/$(ENV) && $(TF) init -reconfigure

docs:
	@cd "$(TF_DIR)"/$(ENV) && terraform-docs markdown table --output-file README.md --output-mode inject .

help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

