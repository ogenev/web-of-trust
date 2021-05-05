// SPDX-License-Identifier: MIT

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

    function toString(address subject) internal pure returns (string memory) {
        bytes memory data = abi.encodePacked(subject);
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(2 + data.length * 2);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < data.length; i++) {
            str[2 + i * 2] = alphabet[uint(uint8(data[i] >> 4))];
            str[3 + i * 2] = alphabet[uint(uint8(data[i] & 0x0f))];
        }
        return string(str);
    }

    function addCertification(
        address subject,
        string memory level
    )
    public returns (bytes32 recordHash) {
        address issuer = msg.sender;
        bytes32 hashRecord = sha256(abi.encodePacked(toString(subject), toString(issuer), level));
        hashSum = sha256(abi.encodePacked(hashSum, hashRecord));

        emit LogAddCertification(subject, issuer, level, hashRecord, hashSum);
        return hashRecord;
    }
}
