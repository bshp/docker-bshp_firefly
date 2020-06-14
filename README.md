#### Apache Tomcat with Apache Web Server, using mod_jk  
  
  Replace the dummy localhost certificates within /src/etc/ssl/ with your host certificate and key, named the same. Modify Apache and Tomcat configs accordingly.  
  
Apache Config: /src/opt/httpd/  
Tomcat Config: /src/opt/tomcat/  
Certificates: /src/etc/ssl/  
Logs: /src/var/log/  
````
docker compose up -d
````
