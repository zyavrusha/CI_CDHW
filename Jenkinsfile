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

        stage('Deploy to production') {
             steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: env.prodSshKey, usernameVariable: env.sshUser )]) {
                    println "sshUser: ${sshUser}" // Debugging line
                    def remote = [:]
                    remote.name = env.prodName // "${prodName}"
                    remote.host = env.prod_ip // "${prodIp}"
                    remote.user =  env.sshUser // "${prodUser}"
                   // remote.identityId = "${prodSshKey}"
                    remote.allowAnyHosts = false
                    remote.known_hosts = env.pathToKnownHosts // "${pathToKnownHosts}"
                    //remote.password = sshPass
                    sshCommand remote: remote, command: "docker ps >> containers_command.txt"
                    }
                }
            
            }
        }

        stage('Clean up environment') {
            steps {
                script {
                    // Using sshCommand to execute a command on a remote server
                    sshCommand remote: [name: 'ubuntusrv', host: '192.168.0.237', identityId: prodSshKey, user: "${prodUser}", known_hosts: "${pathToKnownHosts}", allowAnyHosts: 'false' ], command: "docker ps >> containers_command.txt"
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

