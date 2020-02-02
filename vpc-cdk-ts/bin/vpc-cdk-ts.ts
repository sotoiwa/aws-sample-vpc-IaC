#!/usr/bin/env node
import 'source-map-support/register';
import cdk = require('@aws-cdk/core');
import { VpcCdkTsStack } from '../lib/vpc-cdk-ts-stack';

const app = new cdk.App();
new VpcCdkTsStack(app, 'VpcCdkTsStack');
