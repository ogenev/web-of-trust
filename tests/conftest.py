import pytest


@pytest.fixture(autouse=True)
def setup(fn_isolation):
    """
    Isolation setup fixture.
    This ensures that each test runs against the same base environment.
    """
    pass


@pytest.fixture(scope="module")
def trust_store(accounts, TrustStore):
    """
    Yield a `Contract` object for the TrustStore contract.
    """
    yield accounts[0].deploy(TrustStore)
