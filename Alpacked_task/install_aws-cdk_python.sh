#!/bin/bash
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
add-apt-repository ppa:deadsnakes/ppa
apt install python3.10
python3 -m pip install aws-cdk-lib
npm install -g aws-cdk
npm install -g typescript
npm audit fix
