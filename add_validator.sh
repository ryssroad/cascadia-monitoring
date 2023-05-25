#!/bin/bash

echo -e "\e[1m\e[32m1. Updating dependencies... \e[0m" && sleep 1
sudo apt-get update

echo "=================================================="

echo -e "\e[1m\e[32m2. Installing required dependencies... \e[0m" && sleep 1
sudo apt install jq -y
sudo apt install python3-pip -y
sudo pip install yq

echo "=================================================="

read -p "Enter validator IP: " VALIDATOR_IP
read -p "Enter Prometheus port or hit Enter for default port [26660]: " PROM_PORT
PROM_PORT=${PROM_PORT:-26660}
read -p "Enter valoper address: " VALOPER_ADDRESS
read -p "Enter wallet address: " WALLET_ADDRESS
read -p "Enter project name: " PROJECT_NAME

echo '================================================='
echo -e "validator IP: \e[1m\e[32m$VALIDATOR_IP\e[0m"
echo -e "Prometheus port: \e[1m\e[32m$PROM_PORT\e[0m"
echo -e "valoper address: \e[1m\e[32m$VALOPER_ADDRESS\e[0m"
echo -e "wallet address: \e[1m\e[32m$WALLET_ADDRESS\e[0m"
echo '================================================='
sleep 3

echo -e "\e[1m\e[32m3. Configuring Prometheus... \e[0m" && sleep 1

yq -i -y '.scrape_configs[] |= (.job_name as $name | .static_configs += if $name == "prometheus" then [] else ([{targets:["'$VALIDATOR_IP'" + (if $name == "node" then ":9100" elif $name == "cosmos" then ":'$PROM_PORT'" else ":9300" end)], labels:(if $name == "validator" then {address: "'$VALOPER_ADDRESS'"} elif $name == "wallet" then {address: "'$WALLET_ADDRESS'"} elif $name == "node" then {instance: "'$PROJECT_NAME'"} else {} end)}]) end)' $PWD/prometheus.yml

echo -e "\e[1m\e[32m4. Done! \e[0m" && sleep 1
