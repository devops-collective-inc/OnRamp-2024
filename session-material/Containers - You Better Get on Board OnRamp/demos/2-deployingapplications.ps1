#######################################################################################################################################
# Anthony E. Nocentino
# aen@centinosystems.com
# Required: Enable Kubernetes in Docker Desktop - https://docs.docker.com/desktop/kubernetes/
#######################################################################################################################################

#Deploying resources declaratively in your cluster.
#We can use apply to create our resources from yaml.
#We could write the yaml by hand...but we can use dry-run=client to build it for us
#This can be used a a template for move complex deployments.
#NOTE: Be sure to update the --image parameter to match your repository and impage name.
kubectl create deployment hello-world `
     --image=nocentino/webappimage:v1 `
     --dry-run=client -o yaml | more 


#Let's write this deployment yaml out to file
#NOTE: Be sure to update the --image parameter to match your repository and impage name.
kubectl create deployment hello-world `
     --image=nocentino/webappimage:v1 `
     --dry-run=client -o yaml > deployment.yaml


#The contents of the yaml file show the definition of the Deployment
open deployment.yaml


#Create the deployment...declaratively...in code
kubectl apply -f deployment.yaml


#Generate the yaml for the service
kubectl expose deployment hello-world `
     --port=80 --target-port=80 `
     --dry-run=client -o yaml | more


#Write the service yaml manifest to file
kubectl expose deployment hello-world `
     --port=80 --target-port=80 --type LoadBalancer `
     --dry-run=client -o yaml > service.yaml 


#The contents of the yaml file show the definition of the Service
open service.yaml 


#Create the service declaratively
kubectl apply -f service.yaml 
open http://localhost


#Check out our current state, Deployment, ReplicaSet, Pod and a Service
kubectl get all


#Scale up our deployment...in code
open deployment.yaml
Change spec.replicas from 1 to 20
     replicas: 20


#Update our configuration with apply to make that code to the desired state
kubectl apply -f deployment.yaml


#And check the current configuration of our deployment...you should see 20/20
kubectl get deployment hello-world
kubectl get pods | more 


#Repeat the curl access to see the load balancing of the HTTP request
kubectl get service hello-world
curl http://localhost


#Change the image from v1 to v2. 
open deployment.yaml
kubectl apply -f deployment.yaml
kubectl rollout status deployment hello-world


#Is our application updating to 2.0? 
curl http://localhost


#You can also scale a deployment using scale
kubectl scale deployment hello-world --replicas=40
kubectl get deployment hello-world


#Let's clean up our deployment and remove everything
kubectl delete deployment hello-world
kubectl delete service hello-world
kubectl get all
