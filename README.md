# monerodock

dockerized monero node for mainnet, stagenet, testnet, and a personal local net.


## Requirements

- linux or macOS


## Install

1. Download and Install [docker](https://docs.docker.com/get-docker/)
2. Download and Install [docker-compose](https://docs.docker.com/compose/install/)
3. `git clone https://github.com/vanities/monerodock.git`


## Run Locally

### mainnet

```
$ make
```

### stagenet

```
$ make up-stage
```

### testnet

```
$ make up-test
```

### localenet

```
$ make up-local
```

## Running all the time

This is for installing as a long running service for systemd


### Install

```
$ make install
```

### Restart

```
$ make service-restart
```

### Check the Status

```
$ make service-status
```


### Uninstall

```
$ make uninstall
```
