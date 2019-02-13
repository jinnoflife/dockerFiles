#get the shopware files
FROM debian:jessie-slim as stageZero
ENV neededVersion=latest

WORKDIR /workdir

ADD ./inc/shopwareDownload.sh shopwareDownload.sh
ADD ./inc/additionalVariables.less additionalVariables.less
RUN apt-get -qq update \
    && apt-get -qq upgrade \
    && apt-get -qq install wget zip \
    && chmod +x shopwareDownload.sh
RUN ./shopwareDownload.sh $neededVersion \
    && echo '@import "additionalVariables";' > compileChecker.less \
    && echo '@import "includes/themes/Frontend/Bare/frontend/_public/src/less/all";' >> compileChecker.less \
    && echo '@import "includes/themes/Frontend/Responsive/frontend/_public/src/less/all";'  >> compileChecker.less \
    && echo '@import "frontend/_public/src/less/all";' >> compileChecker.less
#final stage
FROM node:alpine as stageFinal
WORKDIR /workdir
COPY --from=stageZero /workdir .
RUN npm install -g lodash less jshint
