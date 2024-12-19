# old image
FROM gibbz/websync:latest as builder
WORKDIR /build
COPY . .
RUN cp -rf /src ./


# new image
FROM mhart/alpine-node:base-0.10

# copy modules and stuff from original image
COPY --from=builder /build/src/ /src/
COPY . .

# rsync and ssh stuff
RUN apk add --no-cache rsync sshpass openssh-client tzdata

# cron needs the init system
RUN apk add busybox-initscripts openrc --no-cache

# link sh to bash to save space
RUN ln -s /bin/sh /bin/bash

# config ssh
RUN mkdir -p ~/.ssh \
    && chmod 700 ~/.ssh \
    && ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -q -N ""
    
# ssh config
RUN echo "Host *" > /root/.ssh/config && \
    echo "StrictHostKeyChecking no" >> /root/.ssh/config && \
    echo "IdentityFile /root/.ssh/id_rsa" >> /root/.ssh/config

WORKDIR /src

# port
EXPOSE 3000

ENTRYPOINT []
CMD ["node", "server.js"]
