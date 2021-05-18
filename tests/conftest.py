import pytest


@pytest.fixture(scope="function", autouse=True)
def isolate(fn_isolation):
    # выполнять откат цепи после завершения каждого теста, чтобы обеспечить надлежащую изоляцию
    # https://eth-brownie.readthedocs.io/en/v1.10.3/tests-pytest-intro.html#isolation-fixtures
    pass


@pytest.fixture(scope="module")
def token(CrowdBuy, accounts):
    return CrowdBuy.deploy(1621319849, 300,
                           1 ** 18, accounts[1], 15,
                           {'from': accounts[0]})
