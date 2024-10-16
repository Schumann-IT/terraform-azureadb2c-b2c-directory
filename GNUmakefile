docs:
	@echo "Generating docs ..."
	@rm -f .terraform.lock.hcl
	@terraform-docs markdown --output-file README.md .

validate:
	@echo "Validating ..."
	@terraform init -backend=false
	@terraform validate
	@echo "Checking code with tflint ..."
	@tflint --init
	@tflint --fix

fmt:
	@terraform fmt -recursive

pre-commit: fmt validate docs

clean-all: clean clean-examples

clean:
	@rm -Rf .terraform
	@rm -Rf .terraform.lock.hcl

clean-examples:
	@$(foreach dir, $(wildcard ./examples/*/.terraform), rm -Rf $(dir);)
	@$(foreach file, $(wildcard ./examples/*/.terraform.lock.hcl), rm -Rf $(file);)
