FROM ubuntu

RUN apt-get update && apt-get install -y default-jre curl

COPY minecraft/ /minecraft
COPY entrypoint.sh /entrypoint.sh

WORKDIR minecraft

Entrypoint ["/entrypoint.sh"]
