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
    echo "https://goerli.etherscan.io/address/$na"
    echo "Your chequebook: ${bold}$cba${normal}"
    echo "https://goerli.etherscan.io/address/$cba"
    echo ""
    echo -e "${COLOR_GREEN}🐝${COLOR_NC} Bee node is running"
    echo -n "Peers now: "; curl -s http://localhost:1635/peers | jq '.peers | length'
    echo ""
    echo -n "Cashout info:"
    ls -ahl | grep cash.log
    echo ""
    echo -n "Disc space:";
    df -h -t ext4
    echo ""
else
    echo -e "${COLOR_RED}🐝${COLOR_NC} Bee node is NOT RUNNING!"
fi
