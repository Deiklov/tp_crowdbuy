import pytest
import time


@pytest.fixture(scope="function", autouse=True)
def isolate(fn_isolation):
    # выполнять откат цепи после завершения каждого теста, чтобы обеспечить надлежащую изоляцию
    # https://eth-brownie.readthedocs.io/en/v1.10.3/tests-pytest-intro.html#isolation-fixtures
    pass


@pytest.fixture(scope="module")
def contract(CrowdBuy, accounts):
        return CrowdBuy.deploy(int(time.time())+10000000, 300,
                               1*10**18, accounts[1], 15,
                               {'from': accounts[0]})
