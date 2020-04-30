FROM alpine as jar

RUN wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar

FROM ubuntu

RUN apt-get update && apt-get install -y default-jre

COPY minecraft/ /minecraft

WORKDIR minecraft

COPY --from=jar server.jar /

Entrypoint ["/usr/bin/java", "-Xmx6G", "-jar", "/server.jar", "nogui"]
