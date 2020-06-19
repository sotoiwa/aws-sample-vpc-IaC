# Terraform

- https://www.terraform.io/docs/providers/aws/index.html

## Terraformのインストール

`tfenv`を使ってTerraformをイントールする。

```shell
brew search tfenv
brew install tfenv
tfenv --version
tfenv list-remote
tfenv install 0.12.13
```

## デプロイ

Terraformでプロビジョニングを実行する。

```shell
terraform init
terraform plan
terraform apply -auto-approve
```

## 削除

削除する。

```shell
terraform destroy
```
