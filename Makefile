push:
	docker build . -t ethanj/minecraft-server
	docker push ethanj/minecraft-server

up:
	terraform apply -auto-approve
	gcloud container clusters get-credentials minecraft
	kubectl apply -f kube
	kubectl get pods
	sleep 45
	kubectl get pods
	kubectl logs minecraft
	kubectl describe service minecraft | grep --color=never Ingress

delete-pods:
	kubectl delete --all pods --grace-period=60

down: delete-pods
	terraform destroy -auto-approve

get-ip:
	kubectl describe service minecraft | grep --color=never Ingress

mail-ip:

	kubectl describe service minecraft | grep --color=never Ingress
