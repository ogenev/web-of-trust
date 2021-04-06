pragma solidity >=0.8.3 <0.9.0;

contract TrustStore {
    struct Profile {
        address identity;
    }

    struct Certification {
        Profile subject;
        Profile issuer;
        string level;
    }

    string[4] levels;

    constructor() public {
        levels = ['none', "don't care", 'good', 'best'];
    }
}
