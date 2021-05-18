#!/usr/bin/python3.8

from brownie import CrowdBuy, accounts


def main():
    return CrowdBuy.deploy(1621319849, 300,
                           1 ** 18, accounts[1], 15,
                           {'from': accounts[0]})
