#!/usr/bin/python3.8

from brownie import CrowdBuy, accounts
import time

def main():
    return CrowdBuy.deploy(int(time.time())+100000, 300,
                           1 ** 18, accounts[1], 15,
                           {'from': accounts[0]})
