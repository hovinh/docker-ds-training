FROM continuumio/anaconda3:latest
RUN apt-get update
RUN apt-get -y -q install nano
 
VOLUME /host
WORKDIR /host
COPY iris.py /host

CMD /bin/bash
