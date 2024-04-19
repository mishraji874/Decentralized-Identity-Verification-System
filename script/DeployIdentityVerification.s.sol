// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {IdentityVerification} from "../src/IdentityVerification.sol";

contract DeployIdentityVerification is Script {
    function run() external returns (IdentityVerification) {
        vm.startBroadcast();
        IdentityVerification identityVerification = new IdentityVerification();
        vm.stopBroadcast();
        console.log("Contract is deployed at address: ", address(identityVerification));
        return identityVerification;
    }
}