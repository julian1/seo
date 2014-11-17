set -x
/etc/init.d/tomcat7_geonetwork_123 stop 
echo > $l
/etc/init.d/tomcat7_geonetwork_123 start
#less $l
