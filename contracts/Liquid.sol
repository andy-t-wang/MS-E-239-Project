// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

import "@rari-capital/solmate/src/mixins/ERC4626.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Liquid is ERC4626, Ownable {
    uint256 rebasingBalance;
    event Pull(address recipient, uint256 amount);

    constructor(ERC20 _asset) ERC4626(_asset, "LiquidStaking", "LS") {
        rebasingBalance = 0;
    }

    function totalAssets() public view override returns (uint256) {
        return asset.balanceOf(address(this)) + rebasingBalance;
    }

    function pullToStake(uint256 _amount) public onlyOwner {
        asset.transfer(msg.sender, _amount);
        rebasingBalance += _amount;
        emit Pull(msg.sender, _amount);
    }

    function updateEarnings(uint256 _amount) public onlyOwner {
        rebasingBalance = _amount;
    }

    function maxDeposit(address) public view override returns (uint256) {
        return 250 * (10**asset.decimals());
    }
}
