// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract AddLiquidityWETHDAI is Script {
    function run() external {
        address router = 0x41651C87c2a689Cc9EEC3125BDaCe643D4a57846;
        address dai = 0xfbe3Bf8B33995787ab6F967D0c0b124Cc96c352A;
        address weth = 0x5a5a6E83d19AA8a06A15d4aFeef6557593f5fF5a;

        uint daiAmount = 100 ether;     // 100 DAI
        uint wethAmount = 0.01 ether;   // 0.05 WETH

        vm.startBroadcast();

        // Approve both tokens to router
        IERC20(dai).approve(router, daiAmount);
        IERC20(weth).approve(router, wethAmount);

        // Add liquidity with two ERC20 tokens
        IUniswapV2Router02(router).addLiquidity(
            weth,
            dai,
            wethAmount,
            daiAmount,
            0,
            0,
            msg.sender,
            block.timestamp + 300
        );

        vm.stopBroadcast();
    }
}
