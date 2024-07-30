pipeline {
    agent any
    environment {
        // DockerHub credentials
        DOCKER_CREDENTIALS_ID = 'poonam'
        // DockerHub repository
        DOCKER_REPO = 'poonam02/java-app-docker'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url:'https://github.com/02Poonam/CICDJavaAppDocker.git', branch: 'main' 
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and tag it with BUILD_ID
                    def image = docker.build("${DOCKER_REPO}:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the image with both the BUILD_ID tag and the 'latest' tag
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def image = docker.image("${DOCKER_REPO}:${env.BUILD_ID}")
                        image.push("${env.BUILD_ID}") // Push with BUILD_ID tag
                        image.push('latest') // Optionally, also push with 'latest' tag
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    sh """
                    #!/bin/bash
                    docker pull ${DOCKER_REPO}:${env.BUILD_ID}
                    docker stop java-app-docker || true
                    docker rm java-app-docker || true
                    docker run -d --name java-app-docker -p 8081:8081 ${DOCKER_REPO}:${env.BUILD_ID}
                    """
                }
            }
        }
        stage('Print Docker Logs') {
            steps {
                script {
                    sh """
                    #!/bin/bash
                    echo "Fetching logs for java-app-docker..."
                    docker logs java-app-docker
                    """
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
