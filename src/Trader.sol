// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IUniswapV2Router02} from "../lib/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract Trader {
    address private owner;
    IUniswapV2Router02 public uniswap;
    address public WETH;
    address public DAI;

    constructor(address _router, address _weth, address _dai) {
        owner = msg.sender;
        uniswap = IUniswapV2Router02(_router);
        WETH = _weth;
        DAI = _dai;
    }

    function executeTrade(uint amountOutMin) external payable {
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = DAI;

        uniswap.swapExactETHForTokensSupportingFeeOnTransferTokens{ value: msg.value }(
            amountOutMin,
            path,
            msg.sender,
            block.timestamp + 300
        );
    }

    receive() external payable {}
}
