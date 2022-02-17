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

    receive() external payable {
        supplyEth(msg.value);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    function withdraw(
        address cTokenAddress,
        uint256 underlyingAmount,
        address recipient
    ) external onlyAdmin {
        require(
            getUnderlyingBalance(cTokenAddress) >= underlyingAmount,
            "Balance is too low"
        );
        claimComp();
        redeem(cTokenAddress, underlyingAmount);

        address underlyingAddress = getUnderlyingAddress(cTokenAddress); 
        IERC20(underlyingAddress).transfer(recipient, underlyingAmount);

        address compAddress = getCompAddress();
        IERC20 compToken = IERC20(compAddress);
        uint256 compAmount = compToken.balanceOf(address(this));
        compToken.transfer(recipient, compAmount);
    }

    function withdrawEth(
       uint underlyingAmount,
       address payable recipient 
    )onlyAdmin() external{
        require(
            getUnderlyingEthBalance() >= underlyingAmount,
            "Balance is too low"
        );
        claimComp();
        redeemEth(underlyingAmount);
        recipient.transfer(underlyingAmount);

        address compAddress = getCompAddress();
        IERC20 compToken = IERC20(compAddress);
        uint256 compAmount = compToken.balanceOf(address(this));
        compToken.transfer(recipient, compAmount);

    }
}
