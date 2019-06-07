# CycleCheck API Docker Container

A container for running the [API Server](https://github.com/cyclecheck/api-server) for [CycleCheck](https://github.com/cyclecheck/cyclecheck).

![CircleCI](https://img.shields.io/circleci/build/github/cyclecheck/api-server-docker/master.svg?label=release-build) ![CircleCI](https://img.shields.io/circleci/build/github/cyclecheck/api-server-docker.svg?label=build) ![GitHub](https://img.shields.io/github/license/cyclecheck/api-server-docker.svg)

![GitHub release](https://img.shields.io/github/release/cyclecheck/api-server-docker.svg?label=gh-release) ![GitHub commits since latest release](https://img.shields.io/github/commits-since/cyclecheck/api-server-docker/latest/master.svg)

[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

## Features

- Checks if there is a new release of the [API Server](https://github.com/cyclecheck/api-server/releases) on container start.
  - Will automatically download, and install.
- Runs the program using `pm2` so it will always restart if it stops.
- Persist the app data using a `/data` volume.
- New releases for this repo are done automatically by [semantic-release]()
- Every commit is build by [CircleCI](https://circleci.com/gh/cyclecheck/api-server-docker).
  - Any commit to `master` will trigger the running of `semantic-release`.
  - `semantic-release` will analyze the commit messages and determine if a new release is required.
  - Once a new release is publish, Docker Hub will automatically build the new version.

## Building

Available on Docker Hub as [jordond/cyclecheck-api](https://cloud.docker.com/u/jordond/repository/docker/jordond/cyclecheck-api).

### Manual

In case you want to build the image yourself, follow these steps:

```bash
# Clone the repository
git clone https://github.com/cyclecheck/api-server-docker

# Change into directory
cd api-server-docker

# Build the image
docker build -t cyclecheck-api
```

## Running

Create a container:

```bash
docker run -d \
  --name=cyclecheck-api \
  --restart=always \
  -p 9999:8000 \
  -v /path/on/my/machine:/data \
  jordond/cyclecheck-api
```

### Docker Options

- `-p <PORT>:8000`: Local port to map to server
- `-v <PATH_TO_DATA>:/data`: Directory to store all application data, ie: database, config, etc

API will be available at `http://127.0.0.1:9999` (if properly configured, see below).

**Note:** The API server requires that a `cyclecheck.env` file be placed in the `<PATH_TO_DATA>:/data` volume to run.

## Configuring

See [CycleCheck-API](https://github.com/cyclecheck/api-server/blob/master/README.md#setup) for more details.

## Contributing

See [CONTRIBUTING](https://github.com/cyclecheck/api-server-docker/blob/master/.github/CONTRIBUTING.md).

## License

```text
MIT License

Copyright (c) 2019 CycleCheck

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
