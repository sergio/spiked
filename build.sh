#!/bin/bash

BUILD_NUMBER=$(date +"%Y%m%d%H%M%S")
VERSION=1.0.0-qa$BUILD_NUMBER
OUTDIR=$(pwd)/deploy

echo '{"version": "'$VERSION'"}' | jq '.' > $OUTDIR/buildstate.json

echo "Building version $VERSION"

TARGET=$OUTDIR/spiked-server
rm -f $TARGET
cd source
GOOS=linux GOARCH=amd64 go build -ldflags "-X main.version=$VERSION" -o $TARGET .

