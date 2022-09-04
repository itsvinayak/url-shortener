# it will delete all the pods, services, deployments, etc. that have the label group=url-shortener, label is defined in the deployment.yaml and service.yaml files

kubectl delete all -l 'group=url-shortener' &&
kubectl delete pvc \
redis-data-host-path-volume-claim \
--grace-period=0 --force && 
kubectl delete pv \
redis-data-host-path-volume \
--grace-period=0 --force &&
clear && echo "Done deleting"