FROM tomcat:8
COPY target/java-example.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

#Another dockerfile.
#FROM tomcat:8.5.35-jre10
#ADD ./target/web_app.war /usr/local/tomcat/webapps/
#EXPOSE 8080
#RUN chmod +x /usr/local/tomcat/bin/catalina.sh
#CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
