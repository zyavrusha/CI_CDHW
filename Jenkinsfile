pipeline {
    agent any 
    environment {
        BUILD_NUMBER = ${BUILD_NUMBER} // Jenkins provided environment variable
        ImageName = 'zyavrusha/nginx_app_task3'
        dockergubCreds = 'docker-hub' //github credentials
        git_ssh_key = 'git_ssh_access'//access to the git via ssh
        prod_server = 'ubuntusrv' //access to the prod server
    }

    stages {
        stage('Build') { 
            steps {
                echo 'Building..'
            }
        }
        stage('Test'){
            steps{
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps{
                echo 'Deploying....'
            }
        }
    }
}
