.PHONY: up down

export GOOGLE_APPLICATION_CREDENTIALS = $(MY_GCP_CREDENTIALS_FILE)

up:
	ansible-playbook playbook.yaml -e @gcp-vars.yaml

down:
	ansible-playbook playbook.yaml -e @gcp-vars.yaml --tags down
