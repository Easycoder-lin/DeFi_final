// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MinimalRouter.sol";

contract DeployMinimalRouter is Script {
    address constant FACTORY = 0xD324500DC51e96B98f0F6E3A2fF6838C8D082f98;
    address constant WETH = 0x8842e4eAaA3f6190872847DEaD4FF165619D8309;

    function run() external {
        vm.startBroadcast();
        MinimalRouter router = new MinimalRouter(FACTORY, WETH);
        vm.stopBroadcast();

        console.log("MinimalRouter deployed at:", address(router));
    }
}
