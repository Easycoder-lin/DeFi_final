// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MinimalRouter.sol";

contract DeployMinimalRouter is Script {
    address constant FACTORY = 0x4a727c9f3418bDfcc35d72a34e8150F0872d18CE;
    address constant WETH = 0x5a5a6E83d19AA8a06A15d4aFeef6557593f5fF5a;

    function run() external {
        vm.startBroadcast();
        MinimalRouter router = new MinimalRouter(FACTORY, WETH);
        vm.stopBroadcast();

        console.log("MinimalRouter deployed at:", address(router));
    }
}
