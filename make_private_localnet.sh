#!/bin/sh

#
# Commands used for createing private stagenet nodes and wallets
#

set -ex
NETTYPE=stagenet
DIFFICULT=1

cd /monero

# create private wallets

# 56bCoEmLPT8XS82k2ovp5EUYLzBt9pYNW2LXUFsZiv8S3Mt21FZ5qQaAroko1enzw3eGr9qC7X1D7Geoo2RrAotYPx1iovY
echo "" | ./monero-wallet-cli --$NETTYPE --generate-new-wallet /monero/localnet/wallet_01.bin  --restore-deterministic-wallet --electrum-seed="sequence atlas unveil summon pebbles tuesday beer rudely snake rockets different fuselage woven tagged bested dented vegan hover rapid fawns obvious muppet randomly seasons randomly" --password "" --log-file /monero/localnet/wallet_01.log;

./monerod \
   --stagenet \
   --no-igd \
   --hide-my-port \
   --data-dir /monero/localnet \
   --p2p-bind-ip=0.0.0.0 \
   --p2p-bind-port=48080 \
   --rpc-bind-ip=0.0.0.0 \
   --rpc-bind-port=48081 \
   --non-interactive \
   --confirm-external-bind



sleep 3
