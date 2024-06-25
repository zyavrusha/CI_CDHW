pipeline {
    agent any 
    environment {
        BUILD_NUMBER = ${BUILD_NUMBER}
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
