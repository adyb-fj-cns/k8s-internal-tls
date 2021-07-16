APP = webhook-server
NAMESPACE = webhook-demo

.PHONY:cert
cert:
	@./ssl.sh $(APP) $(NAMESPACE)

.PHONY:create-namespace
create-namespace:
	-@kubectl create ns $(NAMESPACE)

.PHONY:create-secret
create-secret:
	@kubectl create secret tls ${APP}-tls --cert=${APP}.pem --key=${APP}.key -n $(NAMESPACE)

.PHONY:clean
clean:
	@rm -vf *.key *.pem *.cert *.crt *.csr

.PHONY:get-ca
get-ca:
	@kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}'