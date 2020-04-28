FROM debian
MAINTAINER wuajf6rf9iul@opayq.com

RUN apt-get update && apt-get install -y tomcat9 wget

RUN wget https://www.enterprise-architecture.org/downloads_area/essentialinstall62b.install

RUN wget http://protege.stanford.edu/download/protege/3.5/installanywhere/Web_Installers/InstData/Linux_64bit/VM/install_protege_3.5.bin

RUN apt-get install -y libservlet3.1-java graphviz

COPY protege-response.txt ./protege-response.txt 
COPY auto-install.xml ./auto-install.xml

RUN chmod u+x install_protege_3.5.bin
#Unfortunately the installer appears to ignore the response file :(
RUN ./install_protege_3.5.bin -f protege-response.txt
RUN java -jar essentialinstall62b.install auto-install.xml 


COPY server.xml /etc/tomcat9/
RUN mkdir /opt/static

COPY index.html /opt/static/
RUN mv install_protege_3.5.bin /opt/static/
RUN tar -C /opt/Essential\ Architecture\ Manager/ -czf /opt/static/essential_metamodel.tar.gz /opt/Essential\ Architecture\ Manager/essential_metamodel/
RUN tar -C /root/Protege_3.5/plugins -czf /opt/static/plugins.tar.gz /root/Protege_3.5/plugins/com.enterprise_architecture.essential.*


USER tomcat9
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

