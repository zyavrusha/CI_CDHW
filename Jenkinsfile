pipeline {
    agent any 
    environment {
        BUILD_NUMBER = '${BUILD_NUMBER}' // Jenkins provided environment variable
        ImageName = 'zyavrusha/nginx_app_task3'
        dockerhubCreds = 'docker-hub' //github credentials
        git_ssh_key = 'git_ssh_access'//access to the git via ssh
        prod_server = 'ubuntusrv' //access to the prod server
    }

    stages {
        stage('Customize index.html') { 
            steps {
                script {
                    sh 'sed -i "s/Build Number:/& ${BUILD_NUMBER}/g" index.html'
                }
            }
        }
     
        stage('Build simple_app image') { 
            steps {
                script {
                    echo "Building the image with build nuber ${BUILD_NUMBER}"
                    // sh 'docker build -t ${ImageName}:${BUILD_NUMBER} .'
                    dockerImage = docker.build("${ImageName}" , '.')
                }
            }
        }
        stage('Push image to Docker Hub') {
            steps{
                script {
                    docker.withRegistry('', dockerhubCreds) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps{
                echo 'Deploying....'
            }
        }
    }
}

