FROM centos:7

# Installing Dependencie(s) 
RUN yum update -y
RUN yum install epel-release -y
RUN yum install wget unzip glibc.i686 git -y

# Exposing Ports Needed
# From Readme File
#------------------------------------------------------
#Incoming UDP to local destination 27015.
#Outgoing UDP to remote destination 27010, 27012, 27040.
#Outgoing TCP to remote destination 7002.
#------------------------------------------------------
EXPOSE 27015/udp 27010/udp 27012/udp 27040/udp
EXPOSE 7002/tcp

COPY deploy_game.sh /root/
RUN chmod +x /root/deploy_game.sh
RUN sh /root/deploy_game.sh

COPY start_game.sh /root/cs_server/Game/
RUN chmod +x /root/cs_server/Game/start_game.sh
ENTRYPOINT ["/usr/bin/sh", "-c", "/root/cs_server/Game/start_game.sh"]

