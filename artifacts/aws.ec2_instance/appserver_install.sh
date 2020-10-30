#!/usr/bin/env bash

mkdir -p /tmp/downloads
cd /tmp/downloads
curl -LO http://download.jboss.org/wildfly/$wildfly_version/wildfly-$wildfly_version.zip
curl -LO http://download.jboss.org/wildfly/$wildfly_version/wildfly-$wildfly_version.zip
curl -LO http://dev.mysql.com/get/Downloads/Connector-J/$MYSQL_DRIVER_VERSION.zip
unzip -q /tmp/downloads/wildfly-$wildfly_version.zip -d /opt
mv /opt/wildfly-$wildfly_version /opt/wildfly
/home/ec2-user/resources/install-mysql-driver.sh
#ADD resources/mgmt-users.properties /opt/wildfly/standalone/configuration/mgmt-users.properties
#ADD resources/mgmt-users.properties /opt/wildfly/domain/configuration/mgmt-users.properties
