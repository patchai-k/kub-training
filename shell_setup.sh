#!/bin/bash

if [ -z $(gcloud config get-value project 2> /dev/null ) ]; then
  echo "PROJECT NOT SET. RUNNING gcloud init"
  echo ""
  gcloud init
fi

export PROJECT_ID=$(gcloud config get-value project)

echo "
## GCP K8S Training
export PROJECT_ID=$PROJECT_ID
gcloud config set project \$PROJECT_ID
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-c
" >> ~/.bashrc

echo "source <(kubectl completion bash)" >> ~/.bashrc
bash -l  

source ~/.bashrc
