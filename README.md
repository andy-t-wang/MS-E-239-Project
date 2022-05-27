# MS&E-239-Project

Liquid Staking:
Implements ERC-4626 Tokenized Vault Standard. The current product is a naieve implementation of liquid staking for long tail assets. Users deposit a specified ERC-20 asset into the contract and are minted shares which can then be redeemed for the underlying. As the assets deposited are used to stake in the network, earnings are sent back to the vault increasing the total underlying value each user holds claim to. To maintain liquidity, 10% of the assets will be left in the vault to permit withdrawals.

Protocol takes a 10% fee on earnings

```
npm i
npx hardhat compile
npx hardhat deploy
```
