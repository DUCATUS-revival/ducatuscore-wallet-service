FROM node:8 as builder

RUN mkdir -p /root/.ssh

ADD ssh_key/id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Create app directory
WORKDIR /src/app

# Install app dependencies
COPY package.json /src/app/
RUN npm install -g grunt bower
RUN npm install

FROM node:8-alpine
WORKDIR /src/app
COPY --from=0 /src/app/node_modules /src/app/node_modules

COPY . /src/app

EXPOSE 3380
EXPOSE 3232
EXPOSE 3231

CMD [ "/bin/bash" ]
