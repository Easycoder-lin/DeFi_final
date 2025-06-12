// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Trader.sol";

contract DeployTrader is Script {
    address constant UNISWAP_ROUTER = 0x463A46d2FFec67AB2966FAb28dDd3b8F3838c2Bd;
    address constant WETH = 0x8842e4eAaA3f6190872847DEaD4FF165619D8309;
    address constant DAI = 0x051Acd6dEd52387c6F0450FF465Eca83d306D806;

    function run() external {
        vm.startBroadcast();
        Trader trader = new Trader(UNISWAP_ROUTER, WETH, DAI);
        vm.stopBroadcast();
    }
}
