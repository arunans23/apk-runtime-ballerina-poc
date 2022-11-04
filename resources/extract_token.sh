export SERVICE_ACCOUNT=api-explorer
export K8S_SERVICE_TOKEN=$(kubectl create token ${SERVICE_ACCOUNT})
export K8S_API_SERVER_URL=https://$(kubectl -n default get endpoints kubernetes --no-headers | awk '{ print $2 }')