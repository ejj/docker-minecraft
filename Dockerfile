FROM alpine as jar

RUN wget https://launcher.mojang.com/v1/objects/a412fd69db1f81db3f511c1463fd304675244077/server.jar

FROM ubuntu

RUN apt-get update && apt-get install -y default-jre

COPY minecraft/ /minecraft

WORKDIR minecraft

COPY --from=jar server.jar /

Entrypoint ["/usr/bin/java", "-Xmx6G", "-jar", "/server.jar", "nogui"]
