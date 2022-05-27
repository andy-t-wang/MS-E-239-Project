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

    /* ========== MUTATIVE FUNCTIONS ========== */

    function pullToStake(uint256 _amount) public onlyOwner {
        asset.transfer(msg.sender, _amount);
        require(_maintainsLiquidity());
        rebasingBalance += _amount;
        emit Pull(msg.sender, _amount);
    }

    function updateEarnings(uint256 _amount) public onlyOwner {
        rebasingBalance = _amount;
    }

    /* ========== VIEW FUNCTIONS ========== */

    function totalAssets() public view override returns (uint256) {
        return ((asset.balanceOf(address(this)) + rebasingBalance) / 10) * 9;
    }

    function maxDeposit(address) public view override returns (uint256) {
        return 250 * (10**asset.decimals());
    }

    /* ========== INTERNAL FUNCTIONS ========== */

    function _maintainsLiquidity() internal view returns (bool) {
        uint256 curBalance = asset.balanceOf(address(this));
        uint256 minBalance = totalAssets() / 10;

        return curBalance >= minBalance;
    }
}
