// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Trader.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TraderTest is Test {
    Trader public trader;

    address public constant UNISWAP_ROUTER = 0x41651C87c2a689Cc9EEC3125BDaCe643D4a57846;
    address public constant WETH = 0x5a5a6E83d19AA8a06A15d4aFeef6557593f5fF5a;
    address public constant DAI = 0xfbe3Bf8B33995787ab6F967D0c0b124Cc96c352A;

    address public owner;

    function setUp() public {
        owner = address(this);

        // Deploy Trader with Sepolia router + token addresses
        trader = new Trader(UNISWAP_ROUTER, WETH, DAI);

        // Give the trader some Sepolia ETH to simulate trade
        vm.deal(address(trader), 0.05 ether);
        vm.deal(owner, 0.05 ether);
    }

    function testExecuteTrade() public {
        uint amountInETH = 0.01 ether;
        uint minDAIOut = 1 ether; // e.g. 1 DAI minimum

        // Call the trade
        trader.executeTrade{value: amountInETH}(minDAIOut);

        // Check owner receives some DAI
        uint daiBalance = IERC20(DAI).balanceOf(owner);
        assertGt(daiBalance, 0, "No DAI received");
    }
}
