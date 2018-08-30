echo off

#cleanup all resources
kubectl delete ingress app-ingress
kubectl delete deployment.extensions/kubernetes-bootcamp
kubectl delete service/kubernetes-bootcamp-service1

kubectl delete namespace ingress
kubectl delete ClusterRoleBinding nginx-role
kubectl delete clusterroles nginx-role

#wait
echo 'waiting 10 seconds to cleanup'
sleep 10

#creating resources
kubectl create namespace ingress

kubectl create -f app-deployment.yaml
kubectl create -f app-service.yaml

kubectl create -f default-backend-service.yaml -n ingress
kubectl create -f default-backend-deployment.yaml -n ingress
kubectl create -f nginx-ingress-controller-config-map.yaml -n ingress
kubectl create -f nginx-ingress-controller-roles.yaml -n ingress
kubectl create -f nginx-ingress-controller-deployment.yaml -n ingress
kubectl create -f app-ingress.yaml
kubectl create -f nginx-ingress-controller-service.yaml -n ingress

#wait
sleep 2
kubectl get pods,services,deployments --all-namespaces  -o wide
echo 'waiting 20 seconds to initialize'
sleep 20
kubectl get pods,services,deployments --all-namespaces  -o wide

#test
echo 'Testing connectivity'
curl sentinel-dev-156.labs.blr.novell.com:30000/app1

