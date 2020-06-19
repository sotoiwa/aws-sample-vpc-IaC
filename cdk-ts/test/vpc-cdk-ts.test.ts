import { expect as expectCDK, matchTemplate, MatchStyle } from '@aws-cdk/assert';
import cdk = require('@aws-cdk/core');
import VpcCdkTs = require('../lib/vpc-cdk-ts-stack');

test('Empty Stack', () => {
    const app = new cdk.App();
    // WHEN
    const stack = new VpcCdkTs.VpcCdkTsStack(app, 'MyTestStack');
    // THEN
    expectCDK(stack).to(matchTemplate({
      "Resources": {}
    }, MatchStyle.EXACT))
});