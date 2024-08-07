# Terraform

## Configurando o Terraform

Antes de criar a infraestrutura na AWS será preciso criar uma nova chave ssh para interagir remotamente com o servidor:

```
ssh-keygen -t ed25519 -C seunome@teste
```

_Obs: essa chave deve ser salva no diretório padrão do linux (~/.ssh)_

Agora precisamos descobrir nosso endereço IP público para permitir o tráfego na porta 22 (SSH) e na porta 3000 (Grafana) da instância EC2. Para tal é possível usar o site [ipinfo](https://ipinfo.io). Com o IP anotado navegue até [esse arquivo](./modules/security_group/main.tf) e altere as linhas 27 e 35 e coloque `seuip/32` no lugar do `0.0.0.0/0` exemplo: `123.234.132.21/32`. Essa configuração permite que só esse endereço IP consiga interagir através do SSH e com a aplicação Grafana dessa instância. Precisamos adicionar a nossa chave pública criada anteriormente [nesse arquivo](./modules/ec2/variables.tf) na linha 24, sem isso a infraestrutura será criada mas não vamos ter acesso SSH. Uma última coisa que precisamos fazer para poder rodar o terraform localmente é remover o backend do s3 que está [nesse arquivo](./versions.tf), basta apenas apagar as 3 linhas (11, 12 e 13).

Por fim, navegue até o diretório `terraform/main/` e inicie a construção da infraestrutura:

```
terraform init
terraform plan
terraform apply
```

Para destruir a infraestrutura:
```
terraform destroy
```
