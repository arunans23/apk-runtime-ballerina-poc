#bin/bash
SERVICE_ACCOUNT=api-explorer
K8S_SERVICE_TOKEN=$(kubectl create token ${SERVICE_ACCOUNT})
K8S_API_ENDPOINT=https://$(kubectl -n default get endpoints kubernetes --no-headers | awk '{ print $2 }')