This project contains Docker file to build image based on Alpine linux, install nginx and then update nginx configuration file and provide custom start page for user. 
Docker container will be up and running on remote server. 
default.conf - simple comnfiguration file for nginx
index.html - custom start page wich will display info about app installed and build number from Jenkins
Jenkinsfile - script to run  pipeline in Jenkins

Do not forget to updated variables with own data
