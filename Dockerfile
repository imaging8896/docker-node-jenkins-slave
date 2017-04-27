FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install git -y

# java
RUN apt-get install curl -y
RUN apt-get update
RUN apt-get install -y software-properties-common && \
	add-apt-repository -y ppa:webupd8team/java && \
	(echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && \
	apt-get update && \
	apt-get install -y oracle-java8-installer
ENV JAVA_OPTS="-Dsun.jnui.encoding=UTF-8 -Dfile.encoding=UTF-8"

ARG SLAVE_VERSION=3.7

# get slave jar
RUN curl --create-dirs -sSLo slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${SLAVE_VERSION}/remoting-${SLAVE_VERSION}.jar \
	&& chmod 644 slave.jar

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash && source ~/.nvm/nvm.sh && nvm install 6
RUN bash && source ~/.nvm/nvm.sh && nvm install 7
