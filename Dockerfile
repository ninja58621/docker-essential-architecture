FROM tomcat:9.0
MAINTAINER wuajf6rf9iul@opayq.com

RUN wget https://essential-cdn.s3.eu-west-2.amazonaws.com/viewer/essential_viewer_692.war

RUN wget https://essential-cdn.s3.eu-west-2.amazonaws.com/import-utility/essential_import_utility_22.war

ADD essential_viewer_692.war /usr/local/tomcat/webapps/

ADD essential_import_utility_22.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
