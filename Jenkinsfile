pipeline {
    agent any 
    environment {
        BUILD_NUMBER = '${BUILD_NUMBER}' // Jenkins provided environment variable
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
                    sh 'echo "Building the image with build number ${BUILD_NUMBER}" >> build.txt'
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

        stage('Clean up environment') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'ubuntusrv', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    script {
                        // Example of using the credentials to make an HTTP request
                        sh 'pwd >> docker_ps.txt'
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

