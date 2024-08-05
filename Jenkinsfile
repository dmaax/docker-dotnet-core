pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // ID das credenciais Docker Hub configuradas no Jenkins
        DOCKER_IMAGE = 'dmaax/dotnet-hello'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/dmaax/docker-dotnet-core.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'dotnet build'
            }
        }
        stage('Test') {
            steps {
                sh 'dotnet test'
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
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

