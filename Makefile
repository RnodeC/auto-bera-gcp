.PHONY: up down

up:
	ansible-playbook gcp/playbook.yaml -e @gcp-vars.yaml

down:
	ansible-playbook gcp/playbook.yaml -e @gcp-vars.yaml --tags down
