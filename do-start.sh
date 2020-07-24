#! /bin/bash

docker kill minecraft
docker rm minecraft
docker pull ethanj/minecraft-server
docker run --name minecraft -d -it --mount "type=bind,source=/mnt/worlds,target=/mnt/worlds" -e WORLD=`hostname` -p 25565:25565 ethanj/minecraft-server
