// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/DAI.sol";

contract DAITest is Test {
    DAI public dai;
    address public user1;
    address public user2;

    function setUp() public {
        // Set up test accounts
        user1 = address(0x1);
        user2 = address(0x2);

        // Deploy DAI as user1
        vm.prank(user1);
        dai = new DAI();
    }

    function testInitialBalance() public view{
        uint256 balance = dai.balanceOf(user1);
        assertEq(balance, 1_000_000 ether, "Initial DAI mint failed");
    }

    function testTransfer() public {
        vm.prank(user1);
        dai.transfer(user2, 100 ether);

        uint256 user2Balance = dai.balanceOf(user2);
        assertEq(user2Balance, 100 ether, "Transfer failed");
    }

    function testTransferFailInsufficientBalance() public {
        // user2 tries to send DAI without having any
        vm.expectRevert();
        vm.prank(user2);
        dai.transfer(user1, 1 ether);
    }
}
