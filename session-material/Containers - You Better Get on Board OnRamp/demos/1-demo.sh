#######################################################################################################################################
# Anthony E. Nocentino
# aen@centinosystems.com
# Docker Desktop is required for these demos - https://www.docker.com/products/docker-desktop 
#######################################################################################################################################
#This is our simple hello world web app and will be included in the downloads.
ls -ls ./v1/webapp


#Step 1 - Build our web app first and test it prior to putting it in a container
dotnet build ./v1/webapp
dotnet run --project ./v1/webapp #Open a new terminal to test.
curl http://localhost:5000


#Step 2 - Let's publish a local build...this is what will be copied into the container
dotnet publish -c Release ./v1/webapp


#Step 3 - Time to build the container and tag it...the build is defined in the Dockerfile
docker build -f ./v1/Dockerfile -t webappimage:v1 .


#Let's check out the current container image...can can start containers from this image
docker image ls webappimage:v1


#Step 4 - Run the container locally and test it out
docker run --name webapp --publish 8080:80 --detach webappimage:v1
curl http://localhost:8080


#Delete the running webapp container
docker stop webapp
docker rm webapp


#Step 5 - Push a container to a container registry
#To create a repository in our registry, follow the directions here
#Create an account at http://hub.docker.com
#https://docs.docker.com/docker-hub/repos/
#https://docs.docker.com/docker-hub/repos/#private-repositories


#Then let's log into docker using the account above.
docker login 


#Tag our image in the format your registry repository/image:tag
#NOTE: You'll be using your own repository, so update that information here. 
docker tag webappimage:v1 nocentino/webappimage:v1


#Now push that locally tagged image into our repository at docker hub
#You'll be using your own repository, so update that information here. 
docker push nocentino/webappimage:v1

open a browser to your repository https://hub.docker.com/repository/docker/nocentino/webappimage


#Before we move on to the next demo, let's build and push a v2 of our application
#NOTE: You'll be using your own repository, so update that information here. 
dotnet publish -c Release ./v2/webapp
docker build -f ./v2/Dockerfile -t webappimage:v2 .
docker tag webappimage:v2 nocentino/webappimage:v2
docker push nocentino/webappimage:v2

