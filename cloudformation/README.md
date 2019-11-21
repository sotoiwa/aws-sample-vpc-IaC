# CloudFormation

- https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/template-reference.html

## デプロイ

```shell
npm install -g cfn-lint
cfn-lint validate vpc.yaml
cfn-lint validate sg.yaml
cfn-lint validate ec2.yaml
aws cloudformation validate-template \
    --template-body file://./vpc.yaml
aws cloudformation validate-template \
    --template-body file://./sg.yaml
aws cloudformation validate-template \
    --template-body file://./ec2.yaml
aws cloudformation deploy \
    --stack-name "sample-vpc" \
    --template-file "vpc.yaml"
aws cloudformation deploy \
    --stack-name "sample-sg" \
    --template-file "sg.yaml"
aws cloudformation deploy \
    --stack-name "sample-ec2" \
    --template-file "ec2.yaml"
```

## 削除

```shell
aws cloudformation delete-stack --stack-name sample-ec2
aws cloudformation delete-stack --stack-name sample-sg
aws cloudformation delete-stack --stack-name sample-vpc
```
