pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // ID das credenciais Docker Hub configuradas no Jenkins
        DOCKER_IMAGE = 'dmaax/dotnet-hello'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/dmaax/docker-dotnet-core.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build Hello/'
            }
        }
        stage('Test') {
            steps {
                sh 'dotnet test Hello/'
            }
        }
        // Builda a imgem docker
        def dockerImage
        stage('Docker Build') {
            steps {
                script {
                    dockerImage = docker.build("${env.DOCKER_IMAGE}:latest")
                }
            }
        }
        // Realiza o push para o Docker Hub
        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials-id') {
                        dockerImage.push()
                    }
                }
            }
        }
        // stage('Docker Login and Push') {
        //     steps {
        //         script {
        //             withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS_ID", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        //                 sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
        //                 sh 'docker push $DOCKER_IMAGE'
        //             }
        //         }
        //     }
        // }
        // stage('Deploy') {
        //     when {
        //         branch 'main'
        //     }
        //     steps {
        //         sshagent(['deploy-key']) {
        //             sh '''
        //             ansible-playbook -i ansible/inventory ansible/deploy.yml
        //             '''
        //         }
        //     }
        // }
    }
}

