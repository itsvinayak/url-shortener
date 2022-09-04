kubectl apply                                    \
    -f app-depolyment.yaml                       \
    -f app-service.yaml                          \
    -f redis-service.yaml                        \
    -f redis-deployment.yaml                     \
    -f redis-hostPathPersistentVolumeClaim.yaml  \
    -f redis-hostPathPersistentVolume.yaml          

# apply the deployment and service for the app
