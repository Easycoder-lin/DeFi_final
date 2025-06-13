
# LeanSwap: Minimal Uniswap V2 with Automated Trading on Sepolia

This project implements a minimal Uniswap V2 deployment on the Sepolia testnet with a simplified custom router. It also includes a DeFi trading bot capable of executing automated token swaps using ETH.

---

## 🌐 Overview

**LeanSwap** is a custom DeFi infrastructure designed for testing and experimentation. It features:

* 🧱 A lightweight Uniswap V2 clone (Factory, Pair)
* 🔀 A minimal custom `UniswapV2Router02` to reduce bytecode size (EIP-170 compliant)
* 🤖 A Trader smart contract for automated ETH → Token swaps
* 🧪 Foundry-based development and deployment scripts
* 🌐 Deployment on Sepolia testnet

---

## 📦 Project Structure

```
.
├── src/
│   ├── UniswapV2Factory.sol
│   ├── UniswapV2Pair.sol
│   ├── MinimalRouter.sol
│   ├── Trader.sol
│   └── interfaces/
├── script/
│   ├── Deploy.s.sol
│   └── CreatePair.s.sol
├── test/
│   └── Trader.t.sol
├── foundry.toml
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

* [Foundry](https://book.getfoundry.sh/getting-started/installation)
* Node.js + Metamask (for interacting via frontend or Sepolia wallet)

### Install Dependencies

```bash
forge install
```

### Compile Contracts

```bash
forge build
```

### Run Tests

```bash
forge test
```

---

## 🛠 Deployment

### 1. Deploy Mock Tokens

```bash
forge script script/DeployMocks.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```
### 2. Deploy Factory

```bash
forge script script/DeployFactory.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

### 3. Deploy Minimal Router

Deploy `MinimalRouter.sol` with:

* `FACTORY`: FACTORY address on Sepolia
* `WETH`: WETH address on Sepolia

```bash
forge script script/DeployMinimalRouter.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

### 4. Create a Trading Pair

Deploy `CreatePair.sol` with:

* `FACTORY`: FACTORY address on Sepolia
* `WETH`: WETH address on Sepolia
* `DAI`: DAI address on Sepolia

```bash
forge script script/CreatePair.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

### 4. Add liquidity to Pair just created

Deploy `Addliquidity.s.sol` with:

* `router`: MinimalRouter address
* * `dai`: DAI address on Sepolia
* `weth`: WETH address on Sepolia


```bash
forge script script/Addliquidity.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

### 5. Deploy Trader Contract

Deploy `Trader.sol` with:

* `ROUTER`: MinimalRouter address
* `WETH`: WETH address on Sepolia
* `DAI`: DAI address on Sepolia

```bash
forge script script/DeployTrader.s.sol --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> --broadcast
```

Once deployed, call `executeTrade()` with ETH.

---

## 🧪 Notes

* The custom router is intentionally minimized to stay within the EVM bytecode size limit.
* Only `swapExactETHForTokensSupportingFeeOnTransferTokens` is implemented.
* Not production-ready — lacks complete safety checks.

---
