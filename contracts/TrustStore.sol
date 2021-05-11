// SPDX-License-Identifier: AGPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract TrustStore {

    bytes32 hashSum = sha256(abi.encodePacked(""));

    event LogAddCertification(
        address subject,
        address issuer,
        string level,
        bytes32 hashRecord,
        bytes32 hashSum
    );

    function getHashSum() public view returns (bytes32) {
        return hashSum;
    }

    function addCertification(
        address issuer,
        string memory level
    )
    public returns (bytes32 recordHash) {
        address subject = msg.sender;
        bytes32 hashRecord = sha256(abi.encodePacked(subject, issuer, level));
        hashSum = sha256(abi.encodePacked(hashSum, hashRecord));

        emit LogAddCertification(subject, issuer, level, hashRecord, hashSum);
        return hashRecord;
    }
}
