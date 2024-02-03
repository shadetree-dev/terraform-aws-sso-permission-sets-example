.PHONY: format init plan apply destroy

# Default command to run when none is specified
default: plan

# Format the Terraform files
format:
	@echo "Formatting Terraform files..."
	@terraform fmt -recursive > /dev/null 2>&1 || true

# Initialize Terraform with backend configuration
init: format
	@echo "Initializing Terraform..."
	terraform init -reconfigure $(TF_ARGS)
	@terraform workspace select -or-create $(TF_VAR_name)

# Create a Terraform plan
plan: format
	@echo "Creating Terraform plan..."
	terraform plan -out=tfplan $(TF_ARGS)

# Apply the Terraform plan
apply: format
	@echo "Applying Terraform plan..."
	terraform apply "tfplan" $(TF_ARGS)

# Destroy the Terraform-managed infrastructure
destroy: format
	@echo "Destroying Terraform-managed infrastructure..."
	terraform destroy $(TF_ARGS)

# removes files that could end up in your repository that shouldn't be
cleanup: format
	@echo "Deleting local files that may contain sensitive details, or are otherwise junk in the repo"
	@for item in .terraform* terraform* *tfplan* *errored*; do \
		rm -rf $$item; \
	done