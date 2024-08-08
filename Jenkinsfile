pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker' // ID das credenciais Docker Hub configuradas no Jenkins
        DOCKER_IMAGE = 'dmaax/dotnet-hello'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout([
                $class: 'GitSCM',
                branches: scm.branches,
                extensions: scm.extensions,
                userRemoteConfigs: [[
                    credentialsId: scm.userRemoteConfigs[0].credentialsId,
                    name: 'origin', 
                    refspec: '+refs/heads/*:refs/remotes/origin/*', 
                    url: scm.userRemoteConfigs[0].url
                ]]])
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

        stage('Terraform Init') {
            when {
                allOf {
                    branch 'master'
                    not { changeRequest() } // Ignora Pull Requests
                }
            }
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            when {
                allOf {
                    branch 'master'
                    not { changeRequest() } // Ignora Pull Requests
                }
            }
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Terraform Apply') {
            when {
                allOf {
                    branch 'master'
                    not { changeRequest() } // Ignora Pull Requests
                }
            }
            steps {
                script {
                    sh 'terraform apply -auto-approve tfplan'
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
