.PHONY: up down

up:
	ansible-playbook playbook.yaml -e @gcp-vars.yaml

down:
	ansible-playbook playbook.yaml -e @gcp-vars.yaml --tags down
