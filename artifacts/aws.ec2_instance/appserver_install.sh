#!/usr/bin/env bash

export MYSQL_DRIVER_VERSION="mysql-connector-java-5.1.40"
export wildfly_version="21.0.0"

mkdir -p /tmp/downloads
cd /tmp/downloads
curl -LO http://download.jboss.org/wildfly/${wildfly_version}.Final/wildfly-${wildfly_version}.Final.zip
sudo unzip -q /tmp/downloads/wildfly-${wildfly_version}.Final.zip -d /opt
sudo mv /opt/wildfly-* /opt/wildfly
sudo /home/ec2-user/resources/install-mysql-driver.sh
sudo cp ~/resources/mgmt-users.properties /opt/wildfly/standalone/configuration/mgmt-users.properties
sudo cp ~/resources/mgmt-users.properties /opt/wildfly/domain/configuration/mgmt-users.properties
nohup sudo /opt/wildfly/bin/standalone.sh -Djboss.bind.address=localhost -Djboss.bind.address.management=localhost &
