# Apollo: Center for Phage Technology Edition

![Apollo Logo](https://github.com/GMOD/Apollo/blob/master/web-app/images/ApolloLogo_100x36.png)

> Apollo is a browser-based tool for visualisation and editing of sequence
> annotations. It is designed for distributed community annotation efforts,
> where numerous people may be working on the same sequences in geographically
> different locations; real-time updating keeps all users in sync during the
> editing process.

This docker image contains *many* non-standard changes that are specific to viral annotations.

## Running the Container

The container is publicly available as `gmod/apollo:stable`. The recommended
method for launching the container is via docker-compose due to a dependency on
a postgres image.

There are a large number of environment variables that can be adjusted to suit
your site's needs. These can be seen in the
[apollo-config.groovy](https://github.com/GMOD/Apollo/blob/master/sample-docker-apollo-config.groovy)
file.

## Quickstart

This procedure starts tomcat in a standard virtualized environment with a PostgreSQL database.

- Install [docker](https://docs.docker.com/engine/installation/) for your system if not previously done.
- `docker run -it -p 8080:8080 erasche/apollo:unified`
- `docker run -it -v this-directory/data/:/data/ -p 8888:8080 gmod/apollo:stable`
- Apollo will be available at http://machine-ip:8888/ (or 8080 if you don't figure the port)

### Logging In

The default credentials in this image are:

| Credentials |                    |
| ---         | ------------------ |
| Username    | `admin@local.host` |
| Password    | `password`         |


### Loading Data

Some sample data is baked into the container for you to play around with:

![](./img/sample.png)

### Chado

Chado support is now baked into the GMOD docker container image.
