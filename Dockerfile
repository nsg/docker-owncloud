FROM ubuntu:vivid
MAINTAINER Stefan Berggren <nsg@nsg.cc>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y wget

ENV REPO_URL http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_15.04/
ENV REPO_KEY http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_15.04/Release.key

RUN echo "deb $REPO_URL /" > /etc/apt/sources.list.d/owncloud.list
RUN wget -O key $REPO_KEY \
	&& echo "76787e60aba374a73294f2baae3026834155acc0  key" | sha1sum -c - \
	&& apt-key add key && rm key

RUN apt-get update && apt-get install -y owncloud
RUN apt-get install -y libreoffice-writer libreoffice-base-core libreoffice-core
RUN apt-get install -y rsync

RUN openssl s_client -connect mail.stefanberggren.se:993 \
	-showcerts </dev/null 2> /dev/null \
	| openssl x509 -outform PEM > /usr/local/share/ca-certificates/mail.crt \
	&& update-ca-certificates

RUN mv /var/www/owncloud /var/www/owncloud.dist

ADD start /start
CMD /start
