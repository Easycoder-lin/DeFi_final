// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/v2-core/contracts/interfaces/IUniswapV2Factory.sol";
import "../lib/v2-core/contracts/interfaces/IUniswapV2Pair.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IWETH is IERC20 {
    function deposit() external payable;
    function withdraw(uint) external;
}

contract MinimalRouter {
    address public immutable factory;
    address public immutable WETH;

    constructor(address _factory, address _WETH) {
        factory = _factory;
        WETH = _WETH;
    }

    receive() external payable {}

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (uint amountToken, uint amountETH, uint liquidity)
    {
        require(block.timestamp <= deadline, "EXPIRED");

        IUniswapV2Factory f = IUniswapV2Factory(factory);
        address pair = f.getPair(token, WETH);
        if (pair == address(0)) {
            pair = f.createPair(token, WETH);
        }

        IERC20(token).transferFrom(msg.sender, pair, amountTokenDesired);
        IWETH(WETH).deposit{value: msg.value}();
        assert(IWETH(WETH).transfer(pair, msg.value));

        amountToken = amountTokenDesired;
        amountETH = msg.value;

        liquidity = IUniswapV2Pair(pair).mint(to);
    }

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable {
        require(path.length == 2, "Only 2-token path supported");
        require(path[0] == WETH, "Must start with WETH");
        require(block.timestamp <= deadline, "EXPIRED");

        IWETH(WETH).deposit{value: msg.value}();
        assert(IWETH(WETH).transfer(IUniswapV2Factory(factory).getPair(path[0], path[1]), msg.value));

        address pair = IUniswapV2Factory(factory).getPair(path[0], path[1]);
        require(pair != address(0), "Pair not found");

        (address token0,) = sortTokens(path[0], path[1]);
        (uint reserveIn, uint reserveOut,) = IUniswapV2Pair(pair).getReserves();
        if (token0 != path[0]) {
            (reserveIn, reserveOut) = (reserveOut, reserveIn);
        }

        uint amountInWithFee = msg.value * 997;
        uint numerator = amountInWithFee * reserveOut;
        uint denominator = reserveIn * 1000 + amountInWithFee;
        uint amountOut = numerator / denominator;
        require(amountOut >= amountOutMin, "Insufficient output");

        IUniswapV2Pair(pair).swap(
            path[1] == IUniswapV2Pair(pair).token0() ? amountOut : 0,
            path[1] == IUniswapV2Pair(pair).token1() ? amountOut : 0,
            to,
            new bytes(0)
        );
    }

    function sortTokens(address tokenA, address tokenB) internal pure returns (address, address) {
        require(tokenA != tokenB, "Identical addresses");
        return tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    }
}
