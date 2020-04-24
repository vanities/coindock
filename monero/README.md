# monerodock

dockerized monero node for mainnet, stagenet, testnet, and a personal local net.


## Requirements

- linux or macOS


## Install

1. Download and Install [docker](https://docs.docker.com/get-docker/)
2. Download and Install [docker-compose](https://docs.docker.com/compose/install/)
3. `git clone https://github.com/vanities/monerodock.git`


## Run Locally

### single node

```
$ ./compose up mainnet
```

### multinode

```
$ ./compose up mainnet testnet stagenet localnet
```

## Running all the time

This is for installing as a long running service for systemd


### Install

```
$ ./compose install mainnet testnet
```


### Uninstall

```
$ ./compose uninstall
```
