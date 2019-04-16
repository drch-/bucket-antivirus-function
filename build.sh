#!/bin/bash
# build lambda function w/ clam-av included
docker build . -t clamav-lambda-build

# create container, copy buid output to dist/, delete container
containerid=$(docker container create clamav-lambda-build)
mkdir -p dist
docker cp $containerid:/dist/lambda.zip ./dist/lambda.zip
docker rm $containerid
