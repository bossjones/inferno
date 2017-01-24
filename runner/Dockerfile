# Version 0.1
FROM ipython/scipystack
MAINTAINER Jon Morton "jon.morton@gmail.com"
ENV REFRESHED_AT 2015-03-19

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get dist-upgrade -y

# Setup
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF
RUN export OS_DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
    export OS_CODENAME=$(lsb_release -cs) && \
    echo "deb http://repos.mesosphere.io/${OS_DISTRO} ${OS_CODENAME} main" | \
    tee /etc/apt/sources.list.d/mesosphere.list &&\
    apt-get -y update

RUN apt-get -y install mesos

RUN apt-get install -y python libnss3 curl

RUN curl http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz \
    | tar -xzC /opt && \
    mv /opt/spark* /opt/spark

RUN apt-get clean

# Fix pypspark six error.
RUN pip2 install -U six
RUN pip2 install msgpack-python
RUN pip2 install avro

COPY spark-conf/* /opt/spark/conf/
COPY scripts /scripts

ENV SPARK_HOME /opt/spark

ENTRYPOINT ["/scripts/run.sh"]
