#!/bin/bash

# ver.0.5.2
export COLOR_NC='\e[0m' # No Color
export COLOR_GREEN='\e[0;32m'
export COLOR_RED='\e[0;31m'
bold=$(tput bold)
normal=$(tput sgr0)
echo ""
echo -n "Bee version " ; bee version
echo ""
if pgrep -x "bee" > /dev/null
then
    na=$( curl -s localhost:1635/addresses | jq .ethereum | tr -d '"')
    cba=$(curl -s localhost:1635/chequebook/address | jq .chequebookaddress | tr -d '"')
    echo "Your address: ${bold}$na${normal}"
    echo "  Etherscan https://goerli.etherscan.io/address/$na"
    echo "Your chequebook: ${bold}$cba${normal}"
    echo "  Etherscan https://goerli.etherscan.io/address/$cba"
    echo ""
    echo -e "Bee node is ${COLOR_GREEN}running :)${COLOR_NC}"
    systemctl status bee | grep 'Active:'
    echo -n "Peers now: "; curl -s http://localhost:1635/peers | jq '.peers | length'
    echo ""
    df -h | grep /dev/vda
else
    echo -e "Bee node is ${COLOR_RED}NOT RUNNING! :(${COLOR_NC}"
    read -p "Do you want try to start node? (Yy/n)" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      systemctl start bee
      echo "Please, wait 30sec and run this utility again..."
      echo "Good Beee!"
      echo "Bzzz..."
      exit 0
    fi
fi
