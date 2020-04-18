SHELL := /bin/bash
DOCKER_NAME := vanities
SERVICE_NAME = monerodock

DOCKER_TAG = $(DOCKER_NAME)/$(SERVICE_NAME):latest

DOCKER_MAIN_PATH = docker-compose.mainnet.yml
DOCKER_TEST_PATH = docker-compose.testnet.yml

DOCKER_COMPOSE = docker-compose --file

VERSION = v0.15.0.5
CHECKSUM = 6cae57cdfc89d85c612980c6a71a0483bbfc1b0f56bbb30e87e933e7ba6fc7e7

# Faucets and info
#https://monerodocs.org/infrastructure/networks/

build:
	$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) build

up: down env build
	$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) up

up-test:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) up

down:
	@echo "Shutting down..."
	@$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) down --remove-orphans
	@$(DOCKER_COMPOSE) $(DOCKER_MAIN_PATH) down --remove-orphans
	@echo "done"

config:
	$(DOCKER_COMPOSE) $(DOCKER_TEST_PATH) config

release:
	 rsync -r . $(URL):/coinmine/$(SERVICE_NAME)

service_start:
	sudo cp services/* /etc/systemd/system
	sudo systemctl start $(SERVICE_NAME).service
	sudo systemctl enable $(SERVICE_NAME).service

service_restart:
	sudo systemctl restart $(SERVICE_NAME).service

service_reload:
	sudo systemctl daemon-reload

service_status:
	sudo systemctl status $(SERVICE_NAME).service

env:
	@sed -e "s/VERSION=.*/VERSION=$(VERSION)/g" .env > tmp
	@mv -- tmp .env
	@sed -e "s/CHECKSUM=.*/CHECKSUM=$(CHECKSUM)/g" .env > tmp
	@mv -- tmp .env
	@sed -e "s/DOCKER_TAG=.*/DOCKER_TAG=$(DOCKER_TAG)/g" .env > tmp
	@mv -- tmp .env
