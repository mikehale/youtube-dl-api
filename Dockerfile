FROM lsiobase/ubuntu:xenial
MAINTAINER nospam <noreply@nospam.nospam>

ENV PYTHONUNBUFFERED=0
ENV PORT=8080
ENV TOKEN=mytoken
ENV EXTHOST=http://localhost
ENV FORMAT="%(title)s - %(uploader)s - %(id)s.%(ext)s"

ARG DEBIAN_FRONTEND="noninteractive"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
    ca-certificates \
    ffmpeg \
    openssl \
    python3 \
    python-pip \
 && pip install youtube-dl && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

COPY root/ /
RUN chmod +x /youtube-dl-api.py

WORKDIR /data
