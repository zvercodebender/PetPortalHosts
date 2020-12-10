#!/usr/bin/env bash

export CLI_VERSION="9.7.0"
#export VERSION="3.1.1"
echo "Version = ${VERSION}"

cd artifacts/aws.ec2_instance
zip -r ../aws.ec2_instance.zip ./*

cd ../..
if [ ! -z "${GET_LOCAL}" ]
then
  xl apply --file petportalhosts.yaml --values version=$VERSION
else
  curl -LO https://dist.xebialabs.com/public/xl-cli/$CLI_VERSION/linux-amd64/xl
  chmod +x xl
  ./xl apply --xl-deploy-url=$XLD_URL --xl-deploy-username=$XLD_USER --xl-deploy-password=$XLD_PASSWD --file petportalhosts.yaml --values version=$VERSION
fi
rm artifacts/aws.ec2_instance.zip
rm xl
