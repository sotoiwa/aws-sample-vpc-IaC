import * as cdk from 'aws-cdk-lib';
import { Template, Match } from 'aws-cdk-lib/assertions';
import VpcCdkTs = require('../lib/vpc-cdk-ts-stack');

test('Empty Stack', () => {
    const app = new cdk.App();
    // WHEN
    const stack = new VpcCdkTs.VpcCdkTsStack(app, 'MyTestStack');
    // THEN

});