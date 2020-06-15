#### Apache Tomcat with Apache Web Server, using mod_jk  
  
  Replace the dummy localhost certificates within /src/opt/httpd/etc/ssl/ with your host certificate and key, named the same. Modify Apache and Tomcat configs accordingly.  
  Apache mod_ssl is already configured for TLS v1.2+, secure ciphers only  
  
Apache Config: /src/opt/httpd/  
Tomcat Config: /src/opt/tomcat/  
Certificates: /src/opt/httpd/etc/ssl/  
Logs: /src/var/log/  
  
````
docker compose up -d
````
  
  You can access your web application at https://localhost/app
