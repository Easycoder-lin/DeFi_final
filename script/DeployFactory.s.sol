// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

interface IFactoryDeployer {
    function deploy(address feeToSetter) external returns (address);
}

contract CallDeployFactory is Script {
    function run() external {
        address factoryDeployer = 0x1c5D63FA1Ea4cFB9FD34b44a420C3DB835dd28bf;
        address feeToSetter = msg.sender; // or any address you want

        vm.startBroadcast();

        address deployedFactory = IFactoryDeployer(factoryDeployer).deploy(feeToSetter);

        vm.stopBroadcast();

        console.log("UniswapV2Factory deployed at:", deployedFactory);
    }
}
