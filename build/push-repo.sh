#!/bin/bash

mkdir -p helm
cd helm  
git config --global user.name "Github Actions"
git config --global user.email "development@kvalitetsit.dk"
git clone https://github.com/KvalitetsIT/helm-repo
cd helm-repo
mkdir -p fstyr-service-chart
cp ../../fstyr-service-chart-*.tgz fstyr-service-chart
helm repo index . --url https://raw.githubusercontent.com/KvalitetsIT/helm-repo/master/
git add -A
git commit -m "Adding new fstyr-service-chart chart"
git push https://$1@github.com/KvalitetsIT/helm-repo
