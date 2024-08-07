<p align="center">
    <h1 align="center">.NET Pipeline</h1>
</p>

<p align="center">
  <a aria-label="Ansible version" href="https://www.ansible.com/">
    <img src="https://img.shields.io/badge/v2.15.3-000.svg?logo=Ansible&labelColor=000&style=for-the-badge">
  </a>
  <a aria-label="awscli version" href="https://aws.amazon.com/cli/">
    <img src="https://img.shields.io/badge/2.13.3-000?style=for-the-badge&logo=amazonwebservices&logoColor=white">
  </a>
  <a aria-label="Jenkins version" href="https://www.jenkins.io/">
    <img src="https://img.shields.io/badge/2.452.3-000?style=for-the-badge&logo=jenkins&logoColor=white">
  </a>
  <a aria-label="Python version" href="https://www.python.org/">
    <img alt="" src="https://img.shields.io/badge/v3.9-000.svg?logo=python&style=for-the-badge">
  </a>
  <a aria-label="Terraform version" href="https://www.terraform.io/">
    <img alt="" src="https://img.shields.io/badge/v1.5.4-000.svg?logo=terraform&logoColor=7B42BC&style=for-the-badge">
  </a>
</p>

## Descrição

Esse repositório possui códigos para configurar de forma declarativa uma infraestrutura básica na AWS (EC2), bem como uma pipeline de ci/cd no Jenkins para um projeto .NET. O código final é deployado através da pipeline na forma de um container Docker para um servidor Ubuntu 24.04 LTS configurado através do Ansible e do Terraform.

## Jenkins

As instruções da pipeline podem ser vistas [aqui](./Jenkinsfile). De forma resumida é feito o checkout no código, depois o build do programa, teste, build da imagem Docker, em seguida o push da mesma e por fim são acionados o Terraform e o Ansible.

## Infra as Code (Terraform e Ansible)

### Terraform

Com o uso do Terraform foram feitos códigos que permitem a criação de uma série de recursos na AWS para criar um servidor Ubuntu Server 24.04 LTS automaticamente. Os códigos podem ser vistos [aqui](./terraform/main/).

### Ansible

Através do Ansible foi criado um playbook que permite a configuração automática de um servidor Ubuntu Server 24.04 LTS, primeiramente é instalado o Docker, depois é realizado o "pull" da imagem Docker criada anteriormente através da pipeline. Em seguida um container novo é criado que roda a mesma imagem. Para visualizar os códigos clique [aqui](./ansible/).