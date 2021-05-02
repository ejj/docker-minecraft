#! /bin/bash

# Make sure Ethan is invited to the project and his SSH key is on the account
# To add the ssh key click on the project in the console. 

# GO here to make a floating IP
# https://console.cloud.google.com/networking/addresses/add?_ga=2.130731916.2021603281.1614471796-652477614.1612743698&project=ray-minecraft&folder=&organizationId=
# gcloud compute addresses create minecraft --region us-west1

#USER=srwisnia@gmail.com
USER=ejj@ej2.org
PROJECT="ray-minecraft-306218"
RAM=6144
CPU=1
IP=34.82.87.29

echo World name?
read WORLD

if [ ! -d "$HOME/google-cloud-sdk" ]; then
    echo "Installing SDK"
    cd $HOME 
    curl -o google-cloud-sdk.tar.gz \
        https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-329.0.0-darwin-x86_64.tar.gz
    tar -xf google-cloud-sdk.tar.gz
    rm google-cloud-sdk.tar.gz
    $HOME/google-cloud-sdk/install.sh -q
fi

GCLOUD=$HOME/google-cloud-sdk/bin/gcloud

echo Booting $WORLD

$GCLOUD auth login $USER --brief
$GCLOUD config set project $PROJECT
$GCLOUD compute firewall-rules create minecraft --allow tcp:25565 || true
$GCLOUD compute instances create-with-container minecraft \
    --zone us-west1-b \
    --container-image ethanj/minecraft-server \
    --container-env=WORLD=$WORLD \
    --disk=name=worlds \
    --container-mount-disk=name=worlds,mount-path=/mnt/worlds \
    --machine-type=n1-custom-$CPU-$RAM \
    --address $IP
