// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/DAI.sol";

contract DeployDAI is Script {
    function run() external {
        vm.startBroadcast();
        DAI dai = new DAI();
        vm.stopBroadcast();

        console.log("DAI deployed at:", address(dai));
    }
}
