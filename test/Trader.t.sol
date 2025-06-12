// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Trader.sol";

interface IUniswapV2Router02 {
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
}

contract TraderTest is Test {
    Trader trader;
    address constant UNISWAP_ROUTER = 0xYourRouterAddress;
    address constant WETH = 0xYourWETHAddress;
    address constant DAI = 0xYourDAIAddress;

    function setUp() public {
        trader = new Trader(UNISWAP_ROUTER, WETH, DAI);
        vm.deal(address(this), 1 ether);
    }

    function testExecuteTrade() public {
        uint amountIn = 0.1 ether;
        uint amountOutMin = 1; // accept slippage for test
        trader.executeTrade{value: amountIn}(amountOutMin);

        // Assert you get some DAI (optional, needs a DAI balance check)
    }
}
