// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/WETH9.sol";
import "../src/MockERC20.sol";

contract DeployMocks is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy mock WETH (depositable)
        WETH9 weth = new WETH9();
        console2.log("WETH deployed to:", address(weth));

        // Deploy mock DAI (ERC20 with fixed supply)
        MockERC20 dai = new MockERC20("Mock DAI", "DAI", 1_000_000 ether);
        console2.log("DAI deployed to:", address(dai));

        vm.stopBroadcast();
    }
}
