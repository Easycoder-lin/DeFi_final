// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../lib/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "../src/DAI.sol";

interface IWETH {
    function deposit() external payable;
    function approve(address spender, uint amount) external returns (bool);
}

contract AddLiquidity is Script {
    address constant ROUTER = 0xD324500DC51e96B98f0F6E3A2fF6838C8D082f98;
    address constant WETH_address = 0x8842e4eAaA3f6190872847DEaD4FF165619D8309;
    address constant DAI_address = 0x051Acd6dEd52387c6F0450FF465Eca83d306D806;

    function run() external {
        vm.startBroadcast();

        // Wrap some ETH
        IWETH(WETH_address).deposit{value: 1 ether}();
        IWETH(WETH_address).approve(ROUTER, type(uint).max);

        // Approve DAI
        DAI(DAI_address).approve(ROUTER, type(uint).max);

        IUniswapV2Router02(ROUTER).addLiquidity(
            WETH_address,
            DAI_address,
            1 ether,
            1000 ether,
            0,
            0,
            msg.sender,
            block.timestamp + 300
        );

        vm.stopBroadcast();
    }

    receive() external payable {}
}
