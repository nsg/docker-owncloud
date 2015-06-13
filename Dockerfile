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

ADD start /start
CMD /start
