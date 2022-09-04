minikube tunnel && 
kubectl get services url-shortener-service | \
awk 'BEGIN{ORS=":8080"} FNR == 2 {print $4}' | \
xargs google-chrome-stable
