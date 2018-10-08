FROM sxzt/ubuntu:latest
MAINTAINER sxzt sjzt2513@163.com

ENV SOFTWARE_ROOT /opt

#copy leanote
ENV LEANOTE_DIR leanote  
ENV LEANOTE_TAR_FILE $LEANOTE_DIR.tar.gz 

ADD $LEANOTE_TAR_FILE $SOFTWARE_ROOT/
#copy mongo
ENV MONGO_DIR mongodb-linux-x86_64-ubuntu1804-4.0.2
ENV MONGO_TAR_FILE $MONGO_DIR.tar.gz
ENV MONGO_NAME mongo

ADD $MONGO_TAR_FILE $SOFTWARE_ROOT/

WORKDIR /opt
RUN mv $MONGO_DIR mongo
#setting enviroment
ENV PATH $SOFTWARE_ROOT/$MONGO_NAME/bin:$PATH

#install mongodb dependencies
RUN apt -y update && \
	apt -y upgrade && \
	apt -y install curl && \
	apt -y install snmpd snmp snmp-mibs-downloader && \
	apt -y clean && \
    apt -y autoclean && \
    apt -y autoremove 

# create mongo dbpath and chmod leanote's run.sh
ENV MONGO_DBPATH /data/mongo
RUN mkdir -p $MONGO_DBPATH  && \
	chmod 777 $SOFTWARE_ROOT/$LEANOTE_DIR/bin/run.sh

EXPOSE 10008	

#copy start bash and chmod
COPY leanote-start.sh /root/
RUN chmod 777 /root/leanote-start.sh

ENTRYPOINT ["/root/leanote-start.sh"]

