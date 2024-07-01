pipeline {
    agent any 
    environment {
        ImageName = "zyavrusha/nginx_app_task3:${BUILD_NUMBER}"
        dockerhubCreds = 'docker-hub' //github credentials
        prodName = 'ubuntusrv' //prod server name
        prodIp = '192.168.0.237' //prod server ip
        prodUser = 'irina' //prod server user
        prodSshKey = 'ssh-ubuntusrv' //access to the prod server via ssh
        pathToKnownHosts = '/var/lib/jenkins/.ssh' //path to known_hosts file
        sshUser = 'irina' //ssh user
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
                    withCredentials([sshUserPrivateKey(credentialsId: env.prodSshKey, keyFileVariable: 'SSH_KEY', usernameVariable: 'USERNAME')]) {
                
                    def remote = [:]
                    remote.name = env.prodName // "${prodName}"
                    remote.host = env.prodIp // "${prodIp}"
                    remote.user = USERNAME
                    remote.identityFile = SSH_KEY
                    remote.allowAnyHosts = true
                    // remote.known_hosts = env.pathToKnownHosts // "${pathToKnownHosts}"
                    //remote.password = PASSWORD
                    sshCommand remote: remote, command: "docker rm \$(docker ps -a -q) -f"
                    sshCommand remote: remote, command: "docker rmi \$(docker images -q) -f"
                    }
                }
            
            }
        }

      
        stage('Deploy') {
            steps{
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: env.prodSshKey, keyFileVariable: 'SSH_KEY', usernameVariable: 'USERNAME')]) {
                
                    def remote = [:]
                    remote.name = env.prodName // "${prodName}"
                    remote.host = env.prodIp // "${prodIp}"
                    remote.user = USERNAME
                    remote.identityFile = SSH_KEY
                    remote.allowAnyHosts = true
                    // remote.known_hosts = env.pathToKnownHosts // "${pathToKnownHosts}"
                    //remote.password = PASSWORD
                    sshCommand remote: remote, command: "docker run -d -p 80:80 --name simple_app ${ImageName}"
                    
                    }
                }
            }
        }
    }
}

