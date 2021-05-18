#!/usr/bin/python3
import brownie


# https://github.com/mixbytes/brownie-example

def test_check_total_sum(accounts, token):
    all_balance = token.getNeededSum()
    assert all_balance == 1 ** 18


def test_check_curr_sum(accounts, token):
    curr_balance = token.getCurrSum()
    assert curr_balance == 0
