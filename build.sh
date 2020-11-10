#!/usr/bin/env bash

export CLI_VERSION="9.7.0"
#export VERSION="3.1.1"
echo "Version = ${VERSION}"

rm artifacts/aws.ec2_instance.zip || true && cd artifacts/aws.ec2_instance && zip -r ../aws.ec2_instance.zip ./* && cd ../..

curl -LO https://dist.xebialabs.com/public/xl-cli/$CLI_VERSION/darwin-amd64/xl
sleep 20

chmod +x xl
./xl apply --xl-deploy-url=$XLD_URL --xl-deploy-username=$XLD_USER --xl-deploy-password=$XLD_PASSWD --file petportalhosts.yaml --values version=$VERSION

rm artifacts/aws.ec2_instance.zip
