up:
	terraform apply -auto-approve

down:
	terraform destroy -auto-approve -var="world=none"


