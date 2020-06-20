#### Apache Tomcat with Apache Web Server, using mod_jk  
  
##### Important Directories  
Apache Config: ``/etc/apache2/``  
Tomcat Config: ``/opt/tomcat/``  
Certificates: ``/etc/ssl/``  
Logs: ``/var/log/``  
  
#### Installation:  
##### Step 1: Download zip from releases
  Download: [Latest Version](https://github.com/bshp/docker-firefly/archive/master.zip)  
  Unzip and Copy to a directory on your server, ``/opt`` is recommended  
  
##### Step 2: Update Certificates  
  Replace the dummy localhost certificates within ``/etc/ssl/`` with your host certificate and key, named the same.  
  
##### Step 3: Add your Application  
  Replace the sample app.war within ``/opt/tomcat/webapps/`` with your WAR, it does not need to be named app.war, anything you like.  
  
##### Step 4 (Optional): Customize Configs  
  Modify Apache and Tomcat configs if needed, located under ``/etc/apache2`` and ``/opt/tomcat``    
  
##### Step 5: Launch Container  
````
docker run \
  --publish 80:80 \
  --publish 443:443 \
  --detach --name firefly \
  --volume /opt/container/logs/apache2:/var/log/apache2 \
  --volume /opt/container/logs/tomcat:/opt/tomcat/logs \
  bshp/firefly:latest
  JAVA_VERSION=11 \
  TOMCAT_VERSION=9.0.36
````  
  
Visit ``https://localhost/app`` in your browser  
  
#### Notes  
Apache:  
mod_ssl is already configured for TLS v1.2+,  
secure ciphers only,  
server tokens prod,  
server signature off  
  
Tomcat:  
Version removed from error pages and the likes  
AJP secret set to default, change to whichever value  
Logging reconfigured, more user friendly .logs for all  
Async enabled  
  
