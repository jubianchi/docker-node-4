#!/bin/bash

opkg-install git

git clone git://github.com/strongloop/express.git
cd express

npm rm --save-dev connect-redis
npm install
npm run-script test-ci
