// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract TrustStore {

    bytes32 hashSum;
    bytes32 newHash;
    address issuer;

    event LogAddCertification(
        address subject,
        address issuer,
        bytes32 level
    );

    function getHashSum() public view returns (bytes32) {
        return hashSum;
    }

    function addCertification(
         address subject,
         bytes32 level
    )
    public returns (bytes32 recordHash) {
        issuer = msg.sender;
        newHash = keccak256(abi.encode(subject, issuer, level));
        hashSum = keccak256(abi.encode(hashSum, newHash));

        emit LogAddCertification(subject, issuer, level);
        return newHash;
    }
}
