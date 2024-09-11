pipeline {
    agent any
    
    stages {
        stage('Pull the code from GitHub to Jenkins workspace') {
            steps {
                git url: 'https://github.com/Amarnath11112/demo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Starting to build Docker image'
                sh 'sudo docker build -t amarnath:$BUILD_NUMBER .'
                echo '#### Successfully built Docker image ####'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        // Tag and push Docker image
                        sh 'docker tag amarnath:${BUILD_NUMBER} amar585/amarnath:${BUILD_NUMBER}'
                        sh 'docker push amar585/amarnath:${BUILD_NUMBER}'
                        echo '#### Successfully pushed Docker image to Docker Hub ####'
                    }
                }
            }
        }
        stage('Deploy Docker Container') {
            steps {
                script {
                    sh """
                        ssh -o StrictHostKeyChecking=no root@18.205.247.219 '
                        docker pull amar585/amarnath:$BUILD_NUMBER &&
                        docker stop amarnath || true &&
                        docker rm amarnath || true &&
                        docker run -d --name amarnath -p 8000:80 amar585/amarnath:$BUILD_NUMBER
                        '
                        """
                    }
                echo '#### Successfully deployed Docker container ####'
            }
        }
    }
}
