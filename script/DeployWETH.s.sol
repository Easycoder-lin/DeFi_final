// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {WETH9} from "../src/WETH9.sol";

contract DeployWETH is Script {
    function run() external {
        vm.startBroadcast();
        WETH9 weth = new WETH9();
        vm.stopBroadcast();

        console.log("WETH deployed at:", address(weth));
    }
}