pipeline {
    agent any 
    environment {
        ImageName = "zyavrusha/nginx_app_task3:${BUILD_NUMBER}"
        dockerhubCreds = 'docker-hub' //github credentials
        git_ssh_key = 'git_ssh_access'//access to the git via ssh
        prod_user = 'iryna' //prod server user
        prod_ip = '192.168.0.237' //prod server ip
        prod_access = 'ubuntusrv' //credential created in Jenkins to access to the Prod server
    }

    stages {
        stage('Customize index.html') { 
            steps {
                script {
                    sh 'sed -i "s/Build Number:/& $BUILD_NUMBER/g" index.html'
                }
            }
        }
     
        stage('Build simple_app image') { 
            steps {
                script {
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
        stage('Clean up environment') {
            steps {
                script {
                    // Using sshCommand to execute a command on a remote server
                    sshCommand remote: [name: "${prod_id}", credentialsId: 'ssh-ubuntusrv'], command: "docker ps >> command.txt"
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

