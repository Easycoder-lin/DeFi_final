// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../lib/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

contract CreatePair is Script {
    address constant FACTORY = 0x4a727c9f3418bDfcc35d72a34e8150F0872d18CE;
    address constant WETH = 0x5a5a6E83d19AA8a06A15d4aFeef6557593f5fF5a;
    address constant DAI = 0xfbe3Bf8B33995787ab6F967D0c0b124Cc96c352A;

    function run() external {
        vm.startBroadcast();
        address pair = IUniswapV2Factory(FACTORY).createPair(WETH, DAI);
        vm.stopBroadcast();

        console.log("Pair deployed at:", pair);
    }
}
