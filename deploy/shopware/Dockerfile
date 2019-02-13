#get the shopware files
FROM debian:jessie-slim as sw_data
ENV neededVersion=latest

WORKDIR /wd

ADD ./inc/shopwareDownload.sh shopwareDownload.sh
ADD ./inc/additionalVariables.less additionalVariables.less

RUN apt-get -qq update \
    && apt-get -qq install -y wget zip > /dev/null \
    && chmod +x shopwareDownload.sh \
    && ./shopwareDownload.sh $neededVersion \
    && echo '@import "./themes/Frontend/Bare/frontend/_public/src/less/variables";\n'\
        '@import "./additionalVariables";\n'\
        '@import "./themes/Frontend/Bare/frontend/_public/src/less/mixins";\n'\
        '@import "./themes/Frontend/Responsive/frontend/_public/src/less/mixins";\n'\
        '@import "./frontend/_public/src/less/all";\n' > compileChecker.less
#final stage
FROM node:alpine as final
WORKDIR /wd
COPY --from=sw_data /wd .
RUN npm install -g lodash less jshint
