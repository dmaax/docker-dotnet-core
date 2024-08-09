pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker' // ID das credenciais Docker Hub configuradas no Jenkins
        DOCKER_IMAGE = 'dmaax/dotnet-hello'
        ANSIBLE_SSH_KEY = credentials('ssh')
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
                    dir('terraform/main') {
                        sh 'terraform init'
                    }
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
                    dir('terraform/main') {
                        sh 'terraform plan -out=tfplan'
                    }
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
                    dir('terraform/main') {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }

        stage('Wait for Host') {
            steps {
                script {
                    echo 'Waiting for the host to become reachable...'
                    sleep 60 // Aguarda 60 segundos para o host ficar online
                }
            }
        }

        stage('Ansible Setup') {
            when {
                allOf {
                    branch 'master'
                    not { changeRequest() } // Ignora Pull Requests
                }
            }
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ssh', keyFileVariable: 'ANSIBLE_SSH_KEY_PATH')]) {
                        dir('ansible') {
                            sh '''
                            cp ${ANSIBLE_SSH_KEY_PATH} /root/.ssh/id_ed25519
                            chmod 600 /root/.ssh/id_ed25519
                            '''

                            sh '''
                            /root/.local/pipx/venvs/ansible/bin/ansible-playbook -i inventory/inventory.ini --private-key=/root/.ssh/id_ed25519 playbooks/it.yml
                            '''
                        }
                    }
                }
            }
        }
    }
}
