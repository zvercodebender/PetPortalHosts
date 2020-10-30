#!/usr/bin/env bash

export MYSQL_DRIVER_VERSION="mysql-connector-java-5.1.40"
export wildfly_version="21.0.0"

mkdir -p /tmp/downloads
cd /tmp/downloads
curl -LO http://download.jboss.org/wildfly/$wildfly_version/wildfly-$wildfly_version.zip
curl -LO http://download.jboss.org/wildfly/$wildfly_version/wildfly-$wildfly_version.zip
curl -LO http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_DRIVER_VERSION}.zip
sudo unzip -q /tmp/downloads/wildfly-${wildfly_version}.zip -d /opt
sudo mv /opt/wildfly-${wildfly_version} /opt/wildfly
/home/ec2-user/resources/install-mysql-driver.sh
sudo cp ~/resources/mgmt-users.properties /opt/wildfly/standalone/configuration/mgmt-users.properties
sudo cp ~/resources/mgmt-users.properties /opt/wildfly/domain/configuration/mgmt-users.properties
