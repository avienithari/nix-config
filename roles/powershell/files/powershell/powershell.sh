#!/bin/bash


echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/powershell.gpg] \
https://packages.microsoft.com/ubuntu/20.04/prod focal main" \
| sudo tee /etc/apt/sources.list.d/powershell.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/powershell.gpg >/dev/null
sudo apt update
