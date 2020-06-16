#### Apache Tomcat with Apache Web Server, using mod_jk  
  
##### Important Directories  
Certificates: ``/firefly/etc/ssl/``  
Apache Config: ``/firefly/opt/httpd/``  
Tomcat Config: ``/firefly/opt/tomcat/``  
Logs: ``/firefly/var/log/``  
  
#### Installation:  
##### Step 1: Download zip from releases
  Download: [Latest Version](https://github.com/bshp/docker-bshp_firefly/archive/master.zip)  
  Unzip and Copy to a directory on your server, ``/opt`` is recommended  
  
##### Step 2: Update Certificates  
  Replace the dummy localhost certificates within ``/firefly/etc/ssl/`` with your host certificate and key, named the same.  
  
##### Step 3: Add your Application  
  Replace the sample app.war within ``/firefly/opt/tomcat/webapps/`` with your WAR, it does not need to be named app.war, anything you like.  
  
##### Step 4 (Optional): Customize Configs  
  Modify Apache and Tomcat configs if needed, located under ``/firefly/opt/httpd`` and ``/firefly/opt/tomcat``    
  
##### Step 5: Launch Container  
``
docker compose up -d
``  
  
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
  
