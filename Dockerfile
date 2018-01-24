FROM ubuntu:14.04
MAINTAINER Thom Nichols "thom@thomnichols.org"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y  curl
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN apt-get install libcap2-bin
RUN echo `which node`
RUN setcap 'cap_net_bind_service=+ep' `which node`

# TODO could uninstall some build dependencies

#RUN update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

VOLUME ["/data"]

ADD . /data
RUN cd /data && npm install

EXPOSE 443
EXPOSE 80
EXPOSE 3330

WORKDIR /data

CMD ["node", "start.js"]