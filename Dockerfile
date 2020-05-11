FROM python:3.6-alpine
MAINTAINER Qubo Tecnologia

ENV PYTHONUNBUFFERED 1
ENV TZ=UTC

RUN apk add --virtual .build-dependencies \
            --no-cache \
            python3-dev \
            build-base \
            linux-headers \
            pcre-dev

RUN apk add --no-cache pcre

COPY . /flask_setup/
WORKDIR /flask_setup


RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN apk del .build-dependencies && rm -rf /var/cache/apk/*

EXPOSE 8000
