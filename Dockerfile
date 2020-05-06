FROM tomcat:9.0
MAINTAINER wuajf6rf9iul@opayq.com

#From Tomcat to manage tomcat install

#Download and Install Required Pre-Requisites

#GraphViz
RUN apt-get install -y libservlet3.1-java graphviz

#Protege 3.5
RUN wget http://protege.stanford.edu/download/protege/3.5/installanywhere/Web_Installers/InstData/Linux_64bit/VM/install_protege_3.5.bin
  
  #Install
  COPY protege-response.txt ./protege-response.txt
  RUN chmod u+x install_protege_3.5.bin
  RUN ./install_protege_3.5.bin -f protege-response.txt
  
#JDBC Drivers
  #This is the standalone install, so we won't be using them




