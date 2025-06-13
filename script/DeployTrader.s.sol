// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Trader.sol";

contract DeployTrader is Script {
    address constant UNISWAP_ROUTER = 0x41651C87c2a689Cc9EEC3125BDaCe643D4a57846;
    address constant WETH = 0x5a5a6E83d19AA8a06A15d4aFeef6557593f5fF5a;
    address constant DAI = 0xfbe3Bf8B33995787ab6F967D0c0b124Cc96c352A;

    function run() external {
        vm.startBroadcast();
        Trader trader = new Trader(UNISWAP_ROUTER, WETH, DAI);
        vm.stopBroadcast();
    }
}
