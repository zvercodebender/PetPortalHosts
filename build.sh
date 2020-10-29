#!/usr/bin/env bash

export VERSION="2.0.0"

cd artifacts/aws.ec2_instance
zip -r ../aws.ec2_instance.zip ./*

cd ../..
xl apply --file petportalhosts.yaml --values version=$VERSION

rm artifacts/aws.ec2_instance.zip
