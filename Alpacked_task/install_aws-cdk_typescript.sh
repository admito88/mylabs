#!/bin/bash
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
npm install aws-cdk-lib
npm install -g aws-cdk
npm install -g typescript
npm audit fix
