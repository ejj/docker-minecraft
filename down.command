#! /bin/bash

GCLOUD=$HOME/google-cloud-sdk/bin/gcloud

echo "Stopping Minecraft Server"
$GCLOUD compute instances delete --zone us-west1-b minecraft --quiet
echo "Done"
