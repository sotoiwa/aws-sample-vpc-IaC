# CloudFormation

- https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/template-reference.html
- https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html

## デプロイ

テンプレートのバリデーションを行う。

```shell
npm install -g cfn-lint
cfn-lint validate vpc.yaml
cfn-lint validate sg.yaml
cfn-lint validate ec2.yaml
aws cloudformation validate-template \
    --template-body file://vpc.yaml
aws cloudformation validate-template \
    --template-body file://sg.yaml
aws cloudformation validate-template \
    --template-body file://ec2.yaml
```

VPCをデプロイする。

```shell
aws cloudformation create-stack \
  --stack-name MyVPCStack \
  --template-body file://vpc.yaml \
  --parameters file://vpc.parameter.json
```

セキュリティグループをデプロイする。

```shell
aws cloudformation create-stack \
  --stack-name MySecurityGroupStack \
  --template-body file://sg.yaml \
  --parameters file://sg.parameter.json
```

EC2インスタンスをデプロイする。

```shell
aws cloudformation create-stack \
  --stack-name MyInstanceStack \
  --template-body file://ec2.yaml \
  --parameters file://ec2.parameter.json
```

## 削除

削除する。

```shell
aws cloudformation delete-stack --stack-name MyInstanceStack
aws cloudformation delete-stack --stack-name MySecurityGroupStack
aws cloudformation delete-stack --stack-name MyVPCStack
```
