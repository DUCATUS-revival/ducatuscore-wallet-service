#FROM ubuntu:16.04
FROM node

RUN apt-get update -y && apt-get install -y git npm nodejs-legacy build-essential libssl-dev

RUN mkdir -p /root/.ssh

ADD ssh_key/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install -g grunt bower
RUN npm install

# Bundle app source
COPY . /usr/src/app

RUN rm /root/.ssh/id_rsa

EXPOSE 3380
EXPOSE 3232
EXPOSE 3231

CMD [ "/bin/bash" ]

