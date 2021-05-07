import hashlib


def test_trust_store_deploy(trust_store):
    """
    Test if the contract is correctly deployed.
    """
    assert trust_store.getHashSum().hex() == hashlib.sha256(b"").hexdigest()


def test_trust_store_add_certification(accounts, trust_store):
    """
    Test hash records and events
    """

    hash_record = trust_store.addCertification(accounts[1].address, 'good', {'from': accounts[0]})
    h = hashlib.sha256()
    h.update(bytes.fromhex(accounts[0].address[2:]))
    h.update(bytes.fromhex(accounts[1].address[2:]))
    h.update(b'good')
    hash_expected = h.digest()

    old_hash_sum = hashlib.sha256(b'').digest()
    new_hash_sum = hashlib.sha256(old_hash_sum)
    new_hash_sum.update(hash_expected)

    assert hash_record.return_value.hex() == hash_expected.hex()
    assert trust_store.getHashSum().hex() == new_hash_sum.hexdigest()

    assert hash_record.events[0]['subject'] == accounts[0].address
    assert hash_record.events[0]['issuer'] == accounts[1].address
    assert hash_record.events[0]['level'] == 'good'
    assert hash_record.events[0]['hashRecord'].hex() == hash_expected.hex()
    assert hash_record.events[0]['hashSum'].hex() == new_hash_sum.hexdigest()
