// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/interfaces/IUniswapV2Factory.sol";

contract CreatePair is Script {
    address constant FACTORY = 0xD324500DC51e96B98f0F6E3A2fF6838C8D082f98;
    address constant WETH = 0x8842e4eAaA3f6190872847DEaD4FF165619D8309;
    address constant DAI = 0x051Acd6dEd52387c6F0450FF465Eca83d306D806;

    function run() external {
        vm.startBroadcast();
        address pair = IUniswapV2Factory(FACTORY).createPair(WETH, DAI);
        vm.stopBroadcast();

        console.log("Pair deployed at:", pair);
    }
}
