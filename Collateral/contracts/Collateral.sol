//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CollateralBackedToken is ERC20 {
    IERC20 public collateral;
    uint256 public price = 1;

    constructor(address _collateral) ERC20("Collateral Backed Token", "CBT") {
        collateral = IERC20(_collateral);
    }

    function deposit(uint256 collateralAmount) external {
        collateral.transferFrom(msg.sender, address(this), collateralAmount);
        _mint(msg.sender, collateralAmount * price);
    }

    function withdraw(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Balance is too low");
        _burn(msg.sender, amount);
        collateral.transfer(msg.sender , amount / price);
    }
}
