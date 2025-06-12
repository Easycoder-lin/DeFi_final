// SPDX-License-Identifier: MIT
pragma solidity =0.5.16;

import "../lib/v2-core/contracts/UniswapV2Factory.sol";

contract FactoryDeployer {
    function deploy(address feeToSetter) public returns (address) {
        UniswapV2Factory factory = new UniswapV2Factory(feeToSetter);
        return address(factory);
    }
}
