#!/usr/bin/env node
import * as cdk from 'aws-cdk-lib';
import { VpcCdkTsStack } from '../lib/vpc-cdk-ts-stack';

const app = new cdk.App();
new VpcCdkTsStack(app, 'VpcCdkTsStack');
