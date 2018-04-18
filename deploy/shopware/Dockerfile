#get the shopware files
FROM debian:jessie-slim as stageZero
ENV neededVersion=5.2.26
WORKDIR /workdir
ADD https://raw.githubusercontent.com/jinnoflife/deployment/master/shopware/inc/shopwareDownload.sh shopwareDownload.sh
ADD https://raw.githubusercontent.com/jinnoflife/deployment/master/shopware/inc/additionalVariables.less additionalVariables.less
RUN apt-get -qq update \
    && apt-get -qq upgrade \
    && apt-get -qq install wget zip \
    && chmod +x shopwareDownload.sh
RUN ./shopwareDownload.sh $neededVersion \
    && echo '@import "./additionalVariables.less";' > compileChecker.less \
    && echo '@import "includes/themes/Frontend/Bare/frontend/_public/src/less/all.less";' >> compileChecker.less \
    && echo '@import "includes/themes/Frontend/Responsive/frontend/_public/src/less/all.less";'  >> compileChecker.less \
    && echo '@import "frontend/_public/src/less/all.less";' >> compileChecker.less
#final stage
FROM node:alpine as stageFinal
WORKDIR /workdir
COPY --from=stageZero /workdir .
RUN npm install -g lodash less jshint
