[![DOI](https://zenodo.org/badge/22018/GMOD/docker-apollo.svg)](https://zenodo.org/badge/latestdoi/22018/GMOD/docker-apollo)

# Apollo

![Apollo Logo](https://github.com/GMOD/Apollo/blob/master/web-app/images/ApolloLogo_100x36.png)

> Apollo is a browser-based tool for visualisation and editing of sequence
> annotations. It is designed for distributed community annotation efforts,
> where numerous people may be working on the same sequences in geographically
> different locations; real-time updating keeps all users in sync during the
> editing process.

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

- Clone docker: `git clone https://github.com/GMOD/docker-apollo`
- `cd docker-apollo`
- Copy JBrowse folders into ./data
- `docker-compose up -d`  # starts the service as a daemon
- Apollo will be shortly be available at [http://localhost:8080/apollo/](http://localhost:8080/apollo/)
- Begin working with Apollo as usual. All directories in `data` are
  accessible in the docker file-system at `/data/` when you add
  directories. Other similarly exposed directories are `apollo` and
  `jbrowse`.

To bring down the container:
- `docker-compose down`

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

Chado support is now baked into the GMOD docker container image. A chado
container is part of the `docker-compose.yml` file and will be started on boot.
You may wish to expose the postgres port (add a `ports: - 5432` to the
docker-compose.yml) if you wish to talk to the Chado container.
