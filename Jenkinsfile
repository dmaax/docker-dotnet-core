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
                    dir('ansible') {
                        // Armazena a chave privada em um arquivo temporário e define permissões seguras
                        writeFile file: '/root/.ssh/id_rsa', text: ANSIBLE_SSH_KEY
                        sh 'chmod 600 /root/.ssh/id_rsa'
                        
                        // Executa o Ansible Playbook usando a chave privada armazenada temporariamente
                        sh '''
                        /root/.local/pipx/venvs/ansible/bin/ansible-playbook -i inventory/inventory.ini --private-key=private_key.pem playbooks/it.yml
                        '''
                    }
                }
            }
        }
    }
}
