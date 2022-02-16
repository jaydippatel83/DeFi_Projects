//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Compound.sol";

contract Wallet is Compound {
    address public admin;

    constructor(address _comptroller, address _cEthAddress)
        Compound(_comptroller, _cEthAddress)
    {
        admin = msg.sender;
    }

    function depost(address cTokenAddress, uint256 underlyingAmount) external {
        address undelyingAddress = getUnderlyingAddress(cTokenAddress);
        IERC20(undelyingAddress).transferFrom(
            msg.sender,
            address(this),
            underlyingAmount
        );
        supply(cTokenAddress, underlyingAmount);
    }
}
