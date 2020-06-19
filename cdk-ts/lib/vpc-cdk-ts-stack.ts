import cdk = require('@aws-cdk/core');
import { SubnetType, Vpc } from '@aws-cdk/aws-ec2'

export class VpcCdkTsStack extends cdk.Stack {
    constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
        super(scope, id, props);

        // https://docs.aws.amazon.com/cdk/api/latest/docs/@aws-cdk_aws-ec2.Vpc.html

        const vpc = new Vpc(this, 'VPC', {
            cidr: "10.0.0.0/16",
            maxAzs: 2,
            subnetConfiguration: [
                {
                    cidrMask: 24,
                    name: 'Public',
                    subnetType: SubnetType.PUBLIC,
                },
                {
                    cidrMask: 24,
                    name: 'Private',
                    subnetType: SubnetType.PRIVATE,
                }
            ]
        });

    }
}
