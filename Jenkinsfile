pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker' // ID das credenciais Docker Hub configuradas no Jenkins
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
                    docker.withRegistry('https://registry.hub.docker.com', env.DOCKER_CREDENTIALS_ID) {
                        dockerImage.push()
                    }
                }
            }
        }
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

