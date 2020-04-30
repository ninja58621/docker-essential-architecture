FROM debian
MAINTAINER wuajf6rf9iul@opayq.com

RUN apt-get update && apt-get install -y tomcat9 wget

#Cut Here

USER tomcat
RUN mkdir /tmp/tomcat9-tomcat9-tmp
#ENV JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server \
#  -Xms1536m -Xmx1536m -XX:NewSize=256m -XX:MaxNewSize=256m \
#  -XX:PermSize=256m -XX:MaxPermSize=256m -XX:+DisableExplicitGC"
CMD ["/usr/lib/jvm/default-java/bin/java", \
"-Djava.util.logging.config.file=/var/lib/tomcat9/conf/logging.properties", \
"-Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager", \
"-Djava.awt.headless=true", \
"-Dfile.encoding=UTF-8", \
"-server", \
"-Xms1536m", \
"-Xmx1536m", \
"-XX:NewSize=256m", \
"-XX:MaxNewSize=256m", \
"-XX:PermSize=256m", \
"-XX:MaxPermSize=256m", \
"-XX:+DisableExplicitGC", \
"-Djava.endorsed.dirs=/usr/share/tomcat9/endorsed", \
"-classpath", "/usr/share/tomcat9/bin/bootstrap.jar:/usr/share/tomcat9/bin/tomcat-juli.jar", \
"-Dcatalina.base=/var/lib/tomcat9", \
"-Dcatalina.home=/usr/share/tomcat9", \
"-Djava.io.tmpdir=/tmp/tomcat9-tomcat9-tmp", \
"org.apache.catalina.startup.Bootstrap", \
"start"]

