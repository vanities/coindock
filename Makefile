SHELL := /bin/bash
DOCKER_NAME := vanities
SERVICE_NAME = monerodock

DOCKER_TAG = $(DOCKER_NAME)\/$(SERVICE_NAME):latest

DOCKER_MAIN_PATH = docker-compose.mainnet.yml
DOCKER_TEST_PATH = docker-compose.testnet.yml
DOCKER_STAGE_PATH = docker-compose.stagenet.yml
DOCKER_LOCAL_PATH = docker-compose.localnet.yml

DOCKER_COMPOSE = docker-compose --file

VERSION = v0.15.0.5
CHECKSUM = 6cae57cdfc89d85c612980c6a71a0483bbfc1b0f56bbb30e87e933e7ba6fc7e7

INSTALL_URL = prod
INSTALL_PATH = /coinmine/stuff

SERVICE_NAME = monero-node


# Faucets and info
#https://monerodocs.org/infrastructure/networks/

up: down build
	$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) up

up-test: build-test
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) up

up-stage: build-stage
	$(DOCKER_COMPOSE) $(DOCKER_STAGE_PATH) up

up-local: build-local
	$(DOCKER_COMPOSE) $(DOCKER_LOCAL_PATH) up

build: env
	$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) build

build-test: env
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) build

build-stage: env
	$(DOCKER_COMPOSE) $(DOCKER_STAGE_PATH) build

build-local: env
	$(DOCKER_COMPOSE) $(DOCKER_LOCAL_PATH) build

down:
	@echo "Shutting down..."
	@$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) down --remove-orphans
	@$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) down --remove-orphans
	@$(DOCKER_COMPOSE) $(DOCKER_LOCAL_PATH) down --remove-orphans
	@$(DOCKER_COMPOSE) $(DOCKER_STAGE_PATH) down --remove-orphans
	@echo "done"

config:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) config

release:
	rsync -r . $(INSTALL_URL):$(INSTALL_PATH)

service_start:
	sudo cp services/* /etc/systemd/system
	#sudo systemctl start $(SERVICE_NAME)-mainnet.service
	#sudo systemctl enable $(SERVICE_NAME)-mainnet.service
	#sudo systemctl start $(SERVICE_NAME)-testnet.service
	#sudo systemctl enable $(SERVICE_NAME)-testnet.service
	sudo systemctl start $(SERVICE_NAME)-stagenet.service
	sudo systemctl enable $(SERVICE_NAME)-stagenet.service
	#sudo systemctl start $(SERVICE_NAME)-localnet.service
	#sudo systemctl enable $(SERVICE_NAME)-localnet.service

service_restart:
	sudo systemctl restart $(SERVICE_NAME)-mainnet.service
	sudo systemctl restart $(SERVICE_NAME)-testnet.service
	sudo systemctl restart $(SERVICE_NAME)-stagenet.service
	sudo systemctl restart $(SERVICE_NAME)-localnet.service

service_reload:
	sudo systemctl daemon-reload

service_status:
	sudo systemctl status $(SERVICE_NAME)-mainnet.service
	sudo systemctl status $(SERVICE_NAME)-testnet.service
	sudo systemctl status $(SERVICE_NAME)-stagenet.service
	sudo systemctl status $(SERVICE_NAME)-localnet.service

env:
	@sed -e "s/VERSION=.*/VERSION=$(VERSION)/g" .env > tmp
	@mv -- tmp .env
	@sed -e "s/CHECKSUM=.*/CHECKSUM=$(CHECKSUM)/g" .env > tmp
	@sed -e "s/DOCKER_TAG=.*/DOCKER_TAG=$(DOCKER_TAG)/g" .env > tmp
	@mv -- tmp .env
