#!/bin/bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
ROOT="$(cd $CWD/.. >/dev/null 2>&1 && pwd)"

set -e

cd $ROOT

VERSION=$1
USERNAME=$2
PASSWORD=$3

IMAGE="jordond/cyclecheck-api"
TAG="latest"
LATEST="$IMAGE:$TAG"
VERSIONED="$IMAGE:$VERSION"

if [ -z "$VERSION" ]; then
  echo "No version was passed in!"
  echo "usage: ./push.sh <version> <username> <password>"
  exit 1
fi

if [ -z "$USERNAME" ]; then
  echo "Username not passed in, looking for: DOCKER_USERNAME"
  USERNAME=$DOCKER_USERNAME
  if [ -z "$USERNAME" ]; then
    echo "No username was passed in!"
    echo "usage: ./push.sh <version> <username> <password>"
    exit 1
  fi
fi

if [ -z "$PASSWORD" ]; then
  echo "Password not passed in, looking for: DOCKER_PASSWORD"

  PASSWORD=$DOCKER_PASSWORD
  if [ -z "$PASSWORD" ]; then
    echo "No password was passed in!"
    echo "usage: ./push.sh <version> <username> <password>"
    exit 1
  fi
fi

echo "Logging into DockerHub."
docker login --username=$USERNAME --password=$PASSWORD 2>/dev/null
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "Unable to login to docker hub!"
  exit 1
fi

echo "Building $LATEST"
docker build -t $LATEST .
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "Unable to build the docker image!"
  exit 1
fi

echo "Deploying $LATEST to docker hub"
docker push $LATEST
ret=$?
if [ ! $ret -eq 0 ]; then
  echo "Unable to push the image to docker hub!"
  exit 1
fi

if [[ "$VERSION" != "skip" ]]; then
  echo "Also deploying $VERSIONED"

  echo "Building $VERSIONED"
  docker build -t $VERSIONED .
  ret=$?
  if [ ! $ret -eq 0 ]; then
    echo "Unable to build the docker image!"
    exit 1
  fi

  echo "Deploying $VERSIONED to docker hub"
  docker push $VERSIONED
  ret=$?
  if [ ! $ret -eq 0 ]; then
    echo "Unable to push the explicit version $VERSIONED to docker hub!"
    exit 1
  fi
fi

echo "Finished"