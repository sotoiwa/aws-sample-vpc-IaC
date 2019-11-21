# Terraform

- https://www.terraform.io/docs/providers/aws/index.html

## Terraformのインストール

```shell
brew search tfenv
brew install tfenv
tfenv --version
tfenv list-remote
tfenv install 0.12.13
```

## デプロイ

```shell
terraform init
terraform plan
terraform apply -auto-approve
```

## 削除

```shell
terraform destroy
```
