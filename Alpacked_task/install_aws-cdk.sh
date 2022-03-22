#!/bin/bash
apt-get install python3-pip -y
pip install aws-cdk.cdk
pip install awscli
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
npm install -g aws-cdk
npm install aws-cdk-lib
npm install -g typescript
npm audit fix
