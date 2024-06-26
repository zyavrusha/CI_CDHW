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
                    def remote = [:]
                    remote.name = "${prodName}"
                    remote.host = "${prodIp}"
                    remote.user = "${prodUser}"
                    remote.identityId = "${prodSshKey}"
                    remote.allowAnyHosts = false
                    sshCommand remote: remote, command: "ls -lrt >> command.txt"
                    //sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
                }
            
            }
        }

        stage('Clean up environment') {
            steps {
                script {
                    // Using sshCommand to execute a command on a remote server
                    sshCommand remote: [name: 'ubuntusrv', host: '192.168.0.237', identityId: "${prodSshKey}", user: "${prodUser}", known_hosts: "${pathToKnownHosts}", allowAnyHosts: 'false' ], command: "docker ps >> containers_command.txt"
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

