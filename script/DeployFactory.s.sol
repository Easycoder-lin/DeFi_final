// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

contract DeployFactory is Script {
    address constant FACTORY = 0xD324500DC51e96B98f0F6E3A2fF6838C8D082f98;

    function run() external {
        vm.startBroadcast();
        IUniswapV2Factory(FACTORY).setFeeTo(msg.sender);
        vm.stopBroadcast();

        console.log("Factory configured at:", FACTORY);
    }
}
