#### Container for Apache Tomcat with Apache Web Server, using mod_jk  
  
Host Certificates: /opt/docker/apache2/ssl  
Host WAR: /opt/docker/tomcat/war  
````
docker run \  
  --detach \ 
  --name appsrv bshp/appsrv:latest \  
  --publish 80:80 \  
  --publish 443:443 \   
  --volume /opt/docker/apache2/ssl:/opt/ssl \  
  --volume /opt/docker/logs/apache2:/var/log/apache2 \  
  --volume /opt/docker/tomcat/war:/opt/war \  
  --env TOMCAT_VERSION=9.0.36  
````
