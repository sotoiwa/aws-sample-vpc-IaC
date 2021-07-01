# CloudFormation

- https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/template-reference.html
- https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html

## デプロイ

テンプレートのバリデーションを行う。

```shell
brew install cfn-lint
cfn-lint vpc.yaml
cfn-lint sg.yaml
cfn-lint ec2.yaml
aws cloudformation validate-template \
    --template-body file://vpc.yaml
aws cloudformation validate-template \
    --template-body file://sg.yaml
aws cloudformation validate-template \
    --template-body file://ec2.yaml
```

VPCをデプロイする。

```shell
aws cloudformation deploy \
  --stack-name MyVPCStack \
  --template-file vpc.yaml \
  --parameter-overrides file://vpc.parameter.json
```

セキュリティグループをデプロイする。

```shell
aws cloudformation deploy \
  --stack-name MySecurityGroupStack \
  --template-file sg.yaml \
  --parameter-overrides file://sg.parameter.json
```

EC2インスタンスをデプロイする。

```shell
aws cloudformation deploy \
  --stack-name MyInstanceStack \
  --template-file ec2.yaml \
  --parameter-overrides file://ec2.parameter.json
```

## 削除

削除する。

```shell
aws cloudformation delete-stack --stack-name MyInstanceStack
aws cloudformation delete-stack --stack-name MySecurityGroupStack
aws cloudformation delete-stack --stack-name MyVPCStack
```
