# we can use minikube service to open the link
# minikube service url-shortener-service or  
# or we can create a tunnel to the service

# jobs -l to see tunnel and kill -9 to kill it
# first run this command to create a tunnel
# minikube tunnel
# then run this command to open the link

kubectl get services url-shortener-service | \
awk 'BEGIN{ORS=":8080"} FNR == 2 {print $4}' | \
xargs google-chrome-stable
