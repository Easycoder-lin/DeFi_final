// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/WETH9.sol"; // adjust path if needed

contract WETH9Test is Test {
    WETH9 public weth;
    address user;
    address spender;

    function setUp() public {
        weth = new WETH9();
        user = address(0xABCD);
        spender = address(0xDCBA);

        // Fund user with ETH
        vm.deal(user, 10 ether);
    }

    function testDeposit() public {
        vm.prank(user);
        weth.deposit{value: 1 ether}();

        assertEq(weth.balanceOf(user), 1 ether);
    }

    function testWithdraw() public {
        // user deposits first
        vm.prank(user);
        weth.deposit{value: 1 ether}();

        // user withdraws
        vm.prank(user);
        weth.withdraw(1 ether);

        assertEq(weth.balanceOf(user), 0);
        assertEq(user.balance, 10 ether); // original 10 ETH restored
    }

    function testApproveAndTransferFrom() public {
        // user deposits WETH
        vm.prank(user);
        weth.deposit{value: 1 ether}();

        // approve spender
        vm.prank(user);
        weth.approve(spender, 0.5 ether);

        // transferFrom by spender
        vm.prank(spender);
        weth.transferFrom(user, spender, 0.5 ether);

        assertEq(weth.balanceOf(spender), 0.5 ether);
        assertEq(weth.allowance(user, spender), 0);
    }

    function testTransfer() public {
        // user deposits WETH
        vm.prank(user);
        weth.deposit{value: 1 ether}();

        // transfer from user to spender
        vm.prank(user);
        weth.transfer(spender, 0.4 ether);

        assertEq(weth.balanceOf(spender), 0.4 ether);
        assertEq(weth.balanceOf(user), 0.6 ether);
    }
}
