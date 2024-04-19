// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract IdentityVerification {

    struct Identity {
        string fullName;
        uint256 idNumber;
        bool isVerified;
    }

    mapping (address => Identity) public identities;

    event IdentityVerified(address indexed user);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function registerIdentity(string memory _fullName, uint256 _idNumber) external {
        require(_idNumber > 0, "ID Number must be greater than zero");
        require(bytes(_fullName).length > 0, "Full name must not be empty");

        identities[msg.sender] = Identity({
            fullName: _fullName,
            idNumber: _idNumber,
            isVerified: false
        });
    }

    function verifyIdentity(address _user) external onlyAdmin {
        Identity storage identity = identities[_user];
        require(bytes(identity.fullName).length > 0, "Identity not registered");
        require(identity.idNumber > 0, "Invalid ID Number");
        require(!identity.isVerified, "Identity already verified");

        identity.isVerified = true;
        emit IdentityVerified(_user);
    }

    function getIdentity(address _user) external view returns (string memory, uint256, bool) {
        Identity memory identity = identities[_user];
        return (identity.fullName, identity.idNumber, identity.isVerified);
    }
}