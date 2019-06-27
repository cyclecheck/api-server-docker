#!/bin/bash

REPO="cyclecheck/api-server"
GH_URL="https://api.github.com/repos/$REPO/releases/latest"

OUTPUT="/opt/app"
BIN="$OUTPUT/cyclecheck-api-standalone/cyclecheck-api"

if [[ ! -z "$1" ]]; then
OUTPUT=$1
fi

echo "Using path: $OUTPUT"

downloadLatestRelease() {
  url=$(curl -sL $GH_URL | jq -r '.assets[].browser_download_url' | grep cyclecheck-api-standalone.zip)
  wget -q -O "$OUTPUT/release.zip" $url

  unzip -o "$OUTPUT/release.zip" -d $OUTPUT
  rm "$OUTPUT/release.zip"

  if [ ! -e /data/cyclecheck.env ]; then
    cp "$OUTPUT/cyclecheck-api-standalone/cyclecheck.sample.env" /data
  fi
}

echo "Checking version for $REPO"
VERSION_LOCAL=$($BIN -v 2>/dev/null)
VERSION_REMOTE=$(curl -sL $GH_URL | jq -r ".name")

set -e

if [[ ! -z "$VERSION_LOCAL" ]]; then
  echo "Local version: $VERSION_LOCAL"
  echo "Remote version: $VERSION_REMOTE"

  if [[ "$VERSION_LOCAL" == "$VERSION_REMOTE" ]]; then
    echo "App is up-to-date!"
  else
    echo "There is an update available!"
    echo "Downloading and installing $VERSION_REMOTE"
    downloadLatestRelease
  fi
else
  echo "Unable to find local version, downloading and installing $VERSION_REMOTE..."
  downloadLatestRelease
fi

version="$($BIN -v)"
echo "Latest version of $REPO:$version is ready to go!"

# Installing PM2
which pm2
hasPm2=$?

if [ $hasPm2 -eq 1 ]; then
  echo "Installing pm2"
  npm install -g pm2 > /dev/null
fi

echo "Finished"