#!/usr/bin/python3.8

from brownie import CrowdBuy, accounts, network
import time
import os

# my metamask address
rinkeby_address = "0xb0Ea766e0D0160F6e97c5B0B8B7b63F34c783e8A"


# export PRIVATE_KEY=metamask key
# export WEB3_INFURA_PROJECT_ID
# brownie run scripts/deploy_testnet.py --network rinkeby

def main():
    if network.show_active() == "rinkeby":
        dev = accounts.add(os.getenv("PRIVATE_KEY"))
        return CrowdBuy.deploy(int(time.time()) + 10000000, 300, 1 * 10 ** 18, rinkeby_address, 15, {'from': dev})
