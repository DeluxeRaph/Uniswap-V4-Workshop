# 🦄 Uniswap v4 Workshop

## **📌 Overview**  
Welcome to the **Uniswap v4** workshop! 🎉 This session will provide a **deep dive** into the **newest version of Uniswap**, covering the architectural changes, **how to build custom hooks**, and **deploy your own Uniswap v4 liquidity pool**.  

📜 **Slides**: [Insert Link]  

---

## **💡 What is Uniswap v4?**  
Uniswap v4 is the **next evolution** of Automated Market Makers (AMMs), introducing:  
- **🪝 Hooks** – Customizable logic that executes **before, during, or after** swaps.  
- **🏛️ Singleton Architecture** – All pools exist within **a single contract**, reducing gas costs.  
- **⚡ Flash Accounting** – More **efficient token transfers**, saving **gas fees**.  
- **💰 Custom Fee Structures** – Developers can set **dynamic fees** via hooks.  

---

## **🔍 Understanding AMMs**  
An **Automated Market Maker (AMM)** is a decentralized exchange mechanism that **replaces order books with liquidity pools**.

### **🔹 Key Concepts**
- **Liquidity Pools**: Users deposit tokens into smart contracts to facilitate swaps.  
- **Constant Product Formula**: `x * y = k` ensures price adjusts with supply & demand.  
- **Liquidity Providers (LPs)**: Earn fees by supplying assets to pools.  
- **Price Slippage**: Large trades impact price due to liquidity depth.  

### **🔄 What’s new in Uniswap v4’s AMM model?**
- **Flash Accounting** reduces redundant token transfers.  
- **Custom Hooks** allow **programmable** pool behavior (e.g., on-chain limit orders).  
- **More flexible LP strategies** via **custom fee mechanisms**.  

---

## **⚙️ Architecture Deep Dive: PoolManager & Hooks**  

### **📌 The `PoolManager` Contract**
In **Uniswap v4**, **pools are no longer standalone contracts**.  
Instead, all pools live inside **one contract**: `PoolManager`.

### **💡 How Hooks Work**
Hooks allow developers to **inject custom logic** at different stages of a swap or liquidity event:
1. **BeforeSwap** – Modify trade behavior (e.g., tax fees, KYC checks).  
2. **AfterSwap** – Implement **rebates, dynamic fees, or token burns**.  
3. **BeforeAddLiquidity** – Enforce **whitelists or LP conditions**.  
4. **AfterRemoveLiquidity** – Auto-compound fees or distribute rewards.  

🚀 **This workshop will guide you through building a custom Hook!**

---

## **🛠 Prerequisites**  

🔹 **Basic Solidity knowledge** – Comfortable with writing & deploying smart contracts.  
🔹 **Foundry installed** – A powerful Ethereum development tool.  

To install Foundry and set up the environment, follow the **"Set up"** section in the **Uniswap v4 template** below.

## **🛠 Using the Uniswap v4 Template**
This workshop is built on top of the **Uniswap v4 Hook Template**. 

You can use these resources to extend your knowledge and experiment with additional custom hook implementations.

# v4-template
### **A template for writing Uniswap v4 Hooks 🦄**

[`Use this Template`](https://github.com/uniswapfoundation/v4-template/generate)

1. The example hook [Counter.sol](src/Counter.sol) demonstrates the `beforeSwap()` and `afterSwap()` hooks
2. The test template [Counter.t.sol](test/Counter.t.sol) preconfigures the v4 pool manager, test tokens, and test liquidity.

<details>
<summary>Updating to v4-template:latest</summary>

This template is actively maintained -- you can update the v4 dependencies, scripts, and helpers: 
```bash
git remote add template https://github.com/uniswapfoundation/v4-template
git fetch template
git merge template/main <BRANCH> --allow-unrelated-histories
```

</details>

---

### Check Forge Installation
*Ensure that you have correctly installed Foundry (Forge) and that it's up to date. You can update Foundry by running:*

```
foundryup
```

## Set up

*requires [foundry](https://book.getfoundry.sh)*

```
forge install
forge test
```

### Local Development (Anvil)

Other than writing unit tests (recommended!), you can only deploy & test hooks on [anvil](https://book.getfoundry.sh/anvil/)

## Scripts Folder Overview

The scripts folder contains Solidity scripts that help automate smart contract deployment and interaction on the blockchain. Scripting in Foundry provides several key capabilities:

- Deploy smart contracts programmatically with custom initialization parameters
- Interact with deployed contracts by calling functions and sending transactions
- Chain multiple contract interactions together in a single script
- Test deployment flows before running them on mainnet
- Configure deployment settings and parameters in a reusable way

```bash
# start anvil, a local EVM chain
anvil

# in a new terminal
forge script script/Anvil.s.sol \
    --rpc-url http://localhost:8545 \
    --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
    --broadcast
```

See [script/](script/) for hook deployment, pool creation, liquidity provision, and swapping.

---

<details>
<summary><h2>Troubleshooting</h2></summary>



### *Permission Denied*

When installing dependencies with `forge install`, Github may throw a `Permission Denied` error

Typically caused by missing Github SSH keys, and can be resolved by following the steps [here](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) 

Or [adding the keys to your ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent), if you have already uploaded SSH keys

### Hook deployment failures

Hook deployment failures are caused by incorrect flags or incorrect salt mining

1. Verify the flags are in agreement:
    * `getHookCalls()` returns the correct flags
    * `flags` provided to `HookMiner.find(...)`
2. Verify salt mining is correct:
    * In **forge test**: the *deployer* for: `new Hook{salt: salt}(...)` and `HookMiner.find(deployer, ...)` are the same. This will be `address(this)`. If using `vm.prank`, the deployer will be the pranking address
    * In **forge script**: the deployer must be the CREATE2 Proxy: `0x4e59b44847b379578588920cA78FbF26c0B4956C`
        * If anvil does not have the CREATE2 deployer, your foundry may be out of date. You can update it with `foundryup`

</details>

---

Additional resources:

[Uniswap v4 docs](https://docs.uniswap.org/contracts/v4/overview)

[v4-periphery](https://github.com/uniswap/v4-periphery) contains advanced hook implementations that serve as a great reference

[v4-core](https://github.com/uniswap/v4-core)

[v4-by-example](https://v4-by-example.org)
