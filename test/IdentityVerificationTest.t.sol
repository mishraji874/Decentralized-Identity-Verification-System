// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {IdentityVerification} from "../src/IdentityVerification.sol";

contract IdentityVerificationTest is Test {
    IdentityVerification verification;
    address alice;
    address bob;
    address public identityContract;

    function setUp() public {
        verification = new IdentityVerification();
        alice = vm.addr(1); // Create address for Alice
        bob = vm.addr(2); // Create address for Bob
        identityContract = address(verification);
    }

    function testRegisterIdentity() external {
        IdentityVerification(identityContract).registerIdentity("John Doe", 12345);
        (string memory fullName, uint256 idNumber, bool isVerified) = IdentityVerification(identityContract).getIdentity(address(this));
        assertEq(fullName, "John Doe");
        assertEq(idNumber, 12345);
        assertFalse(isVerified);
    }

    function testVerifyIdentity() external {
        IdentityVerification(identityContract).registerIdentity("John Doe", 12345);
        IdentityVerification(identityContract).verifyIdentity(address(this));
        (, , bool isVerified) = IdentityVerification(identityContract).getIdentity(address(this));
        assertTrue(isVerified);
    }

    function testGetIdentity() external {
        IdentityVerification(identityContract).registerIdentity("John Doe", 12345);
        (string memory fullName, uint256 idNumber, bool isVerified) = IdentityVerification(identityContract).getIdentity(address(this));
        assertEq(fullName, "John Doe");
        assertEq(idNumber, 12345);
        assertFalse(isVerified);
    }
}