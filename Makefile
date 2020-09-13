up:
	terraform apply -auto-approve

down:
	terraform destroy -auto-approve -var="world=none"

push:
	docker build . -t ethanj/minecraft-server
	docker push ethanj/minecraft-server
