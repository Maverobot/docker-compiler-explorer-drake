# docker-compiler-explorer-drake

[![Build and Publish](https://github.com/maverobot/docker-compiler-explorer-drake/actions/workflows/build.yaml/badge.svg)](https://github.com/maverobot/docker-compiler-explorer-drake/actions/workflows/build.yaml)

A docker-based version of [Matt Godbolt's Compiler Explorer](https://github.com/mattgodbolt/compiler-explorer) for self-hosting purposes.

The repository contains a `Dockerfile` with all the required instructions to build the compiler explorer application (with some adjustments to the Makefile as long as there's no 'sudo') and a `docker-compose.yml` file, which keeps some setup instructions such as the port mapping and network, in case you might want to map the default port exposed by the application, 10240, in an easy way.

## Requirements

* Docker (possibly the latest version, 17.06+)
* docker-compose (1.16+)

## Usage

You can just type the following line to download the docker image and launch the compiler-explorer with drake support locally:

```sh
docker pull maverobot/docker-compiler-explorer-drake:latest
docker run -p 10240:10240 maverobot/docker-compiler-explorer-drake:latest
```

## Local Build/Run instructions

You can just type in your terminal:

```sh
docker pull maverobot/docker-compiler-explorer-drake:latest && docker-compose up -d
```

to use my docker image or, in case of adjustments to the `Dockerfile`, just type:

```sh
docker-compose up -d
```

and you're done. On the first time, it will build the image based on the modified `Dockerfile`.

Once launched, you can just point your browser to http://localhost:10240 (or to the port you've defined in the `docker-compose.yml` file)
