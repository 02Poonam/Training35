pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Build Successful'
                // Add your build steps here
            }
        }
        stage('Test') {
            steps {
                echo 'Test Successful'
                // Add your test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploy Successful'
                // Add your deploy steps here
            }
        }
    }

    post {
        success {
            echo 'Build and test succeeded!'
        }
        failure {
            echo 'Build or test failed!'
        }
    }
}
