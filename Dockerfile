FROM python:alpine

RUN apk add -U git build-base tini openssl-dev \
  && rm -rf /var/cache/apk/*

WORKDIR /opt

RUN git clone https://github.com/opentimestamps/opentimestamps-server \
  -b 'opentimestamps-server-v0.3.0'

WORKDIR /opt/opentimestamps-server

RUN pip install -r requirements.txt \
  && pip install requests

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 14788

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]
