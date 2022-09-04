kubectl apply                                    \
    -f redis-hostPathPersistentVolume.yaml       \
    -f redis-hostPathPersistentVolumeClaim.yaml  \
    -f app-service.yaml                          \
    -f redis-service.yaml                        \
    -f app-depolyment.yaml                       \
    -f redis-deployment.yaml                     &&
    clear                                        &&
    echo "Done deploying"

# apply the deployment and service for the app
