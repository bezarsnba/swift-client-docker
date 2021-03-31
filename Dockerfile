FROM python:3.9.2-alpine AS builder-simple-swiftclient

FROM builder-simple-swiftclient as builder
RUN mkdir /opt/python3/
WORKDIR /opt/python3/

RUN apk add --no-cache alpine-sdk linux-headers
RUN pip3 install python-swiftclient python-keystoneclient --prefix=/opt/python3/ --no-warn-script-location

FROM builder-simple-swiftclient

ENV OS_PROJECT_DOMAIN_ID=default
ENV OS_USER_DOMAIN_ID=default
ENV OS_IDENTITY_API_VERSION=3
ENV OS_ENDPOINT_TYPE=admin

ARG OS_AUTH_URL
ARG OS_USERNAME
ARG OS_PASSWORD
ARG OS_PROJECT_NAME

COPY --from=builder /opt/python3/ /usr/local

VOLUME ["/opt/web/www/html/"]
WORKDIR /opt/web/
