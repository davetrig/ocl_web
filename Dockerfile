FROM python:2.7.13
ENV PYTHONUNBUFFERED 1

RUN set -ex && \
    echo 'deb http://deb.debian.org/debian jessie-backports main' \
      > /etc/apt/sources.list.d/jessie-backports.list && \

    apt update -y && \
    apt install -t \
      jessie-backports \
      openjdk-8-jre-headless \
      ca-certificates-java -y

RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get -y install nodejs 

RUN mkdir /code

ADD . /code/
WORKDIR /code

RUN pip install -r requirements.txt
RUN npm install
RUN npm install -g grunt-cli

EXPOSE 7000

CMD bash startup.sh