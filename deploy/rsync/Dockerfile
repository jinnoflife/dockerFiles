FROM debian:jessie-slim

RUN which ssh-agent || apt-get -qq update -y \
    && apt-get -qq upgrade -y \
    && apt-get -qq install openssh-client rsync -y \
    && mkdir -p ~/.ssh \
    && eval $(ssh-agent -s) \
#    && eval `ssh-agent -s` \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config
