pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'poonam'
        DOCKER_REPO = 'poonam02/java-docker-ansible'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url:'https://github.com/02Poonam/Web-CICDPipeline.git', branch: 'main' 
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def image = docker.build("${DOCKER_REPO}:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                        docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def image = docker.image("${DOCKER_REPO}:${env.BUILD_ID}")
                        image.push("${env.BUILD_ID}")
                        image.push('latest')
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
                    docker stop java-docker-ansible || true
                    docker rm java-docker-ansible || true
                    docker run -d --name java-docker-ansible -p 8081:8081 ${DOCKER_REPO}:${env.BUILD_ID}
                    """
                }
            }
        }
        stage('Print Docker Logs') {
            steps {
                script {
                    sh """
                    #!/bin/bash
                    echo "Fetching logs for java-docker-ansible..."
                    docker logs java-docker-ansible
                    """
                }
            }
        }
    }
}
