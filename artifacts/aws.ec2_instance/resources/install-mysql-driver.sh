export MYSQL_DRIVER_VERSION="mysql-connector-java-5.1.40"
curl -LO http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_DRIVER_VERSION}.zip
unzip -q /tmp/downloads/${MYSQL_DRIVER_VERSION}.zip -d /tmp
count=0
sudo /opt/wildfly/bin/standalone.sh -Djboss.bind.address=localhost -Djboss.bind.address.management=localhost &
while true
do
  if [ $count -le 90 ]; then

    wget --spider -q http://127.0.0.1:8080
    if [ $? -ne 0 ] ;then
      echo "waiting $count"
      sleep 1
      count=$(( count+1 ))
    else
      echo "Website is up"
      sudo /opt/wildfly/bin/jboss-cli.sh -c "deploy /tmp/${MYSQL_DRIVER_VERSION}/${MYSQL_DRIVER_VERSION}-bin.jar"
      break
    fi
  else
    echo "Timeout exceeded...giving up waiting for website"
    exit 1
  fi
done
rm -rf /opt/wildfly/standalone/configuration/standalone_xml_history/current
