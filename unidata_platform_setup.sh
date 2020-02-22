# more a list of notes right now - 2020-02-22
# instructions from here https://gitlab.com/unidata-community/unidata-platform
# Database
#   Create DB manually from psql or PG Admin
#   DB name: unidata
#   owner: postgres
# Install Elasticsearch (versions above 5.6.x will not work, we are in progress migrating our search subsystem to the lastest ES)
#   Install russian/english morphology plugin, if you're going to index and search, using this feature: $ bin/elasticsearch-plugin install http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/5.6.7/elasticsearch-analysis-morphology-5.6.7.zip
# Install Apache Tomcat 7.x using your favorite method
# Unidata uses gradle to build itself
#   Go to org.unidata.mdm.war and build WAR (and its dependencies) with ./gradle clean war
#   Deploy the artifact to tomcat 7.x using your favorite method

# install postgresql
apt install postgresql-10 postgresql-client-common
systemctl enable postgresql
sudo -u postgres -i

# work out of here
cd /opt

# install java
# apt install openjdk-8-jre-headless
# add
# JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
# in /etc/enviroment
apt install openjdk-11-jre-headless
# add (but not JRE_HOME because not used >8)
# JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# in /etc/enviroment
source /etc/environment

# install and start elasticsearch
apt install apt-transport-https
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.7.deb
dpkg -i elasticsearch-5.6.7.deb
systemctl enable elasticsearch.service

# install some language plugin soemthing
/usr/share/elasticsearch/bin/elasticsearch-plugin install http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/5.6.7/elasticsearch-analysis-morphology-5.6.7.zip
systemctl restart elasticsearch.service

# isntall tomcat 7
wget http://mirror.reverse.net/pub/apache/tomcat/tomcat-7/v7.0.100/bin/apache-tomcat-7.0.100.tar.gz
tar xvzf apache-tomcat-7.0.100.tar.gz
# add
# CATALINA_HOME=/opt/apache-tomcat-7.0.100
# in /etc/enviroment
source /etc/environment
# add
# <role rolename="manager-gui"/>
# <user username="admin" password="admin" roles="manager-gui"/>
# in $CATALINA_BASE/conf/tomcat-users.xml
$CATALINA_HOME/bin/startup.sh

# close unidata
git clone https://gitlab.com/unidata-community/unidata-platform.git
cd unidata-platform/
../gradlew clean war
cp org.unidata.mdm.war/build/libs/org.unidata.mdm.war.war $CATALINA_HOME/webapps/unidata.war

# webp at this point i see /unidata on my server and get a 404