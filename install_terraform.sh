#!/bin/bash
TERRAFORM_URL="https://dl.bintray.com/mitchellh/terraform/terraform_0.3.7_linux_amd64.zip"

if [ ! -f ~/bin/terraform ]; then
  mkdir /tmp/terraform
  wget -P /tmp "${TERRAFORM_URL}"
  (
    cd /tmp/terraform && unzip /tmp/*.zip
  )
  cp /tmp/terraform/* ~/bin/
fi
