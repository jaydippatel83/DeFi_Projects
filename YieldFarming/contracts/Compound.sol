//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CTokenInterface.sol";
import "./ComptrollerInterface.sol";

contract Compound {
    ComptrollerInterface public comptroller;

    constructor(address _comptroller) {
        comptroller = ComptrollerInterface(_comptroller);
    }

    function supply(address cTokenAddress, uint256 underlyingAmount) internal {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlaying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.mint(underlyingAmount);
        require(
            result == 0,
            "cToken#mint() failed. see compound Error reporter"
        );
    }

    function redeem(address cTokenAddress, uint256 cTokenAmount) internal {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        uint256 result = cToken.redeem(cTokenAmount);
        require(
            result == 0,
            "cToken#redeem() failed. see compound Error reporter"
        );
    }

    function enterMarket(address cTokenAddress) internal {
        address[] memory markets = new address[](1);
        markets[0] = cTokenAddress;
        uint256[] memory results = comptroller.enterMarkets(markets);
        require(
            results[0] == 0,
            "comptroller#entermarket() failed. see compound Error reporter"
        );
    }

    function borrow(address cTokenAddress, uint256 borrowAmount) internal {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        uint256 result = cToken.borrow(borrowAmount);
        require(
            result == 0,
            "cToken#borrow() failed. see compound Error reporter"
        );
    }

    function repayBorrow(address cTokenAddress, uint256 underlyingAmount)
        internal
    {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlaying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.repayBorrow(underlyingAmount);
        require(
            result == 0,
            "cToken#repayBorrow() failed. see compound Error reporter"
        );
    }

    function claimComp() internal {
        comptroller.claimComp(address(this));
    }

    function getCompAddress() internal view returns (address) {
        return comptroller.getCompAddress();
    }

    function getTokenBalance(address cTokenAddress)
        public
        view
        returns (uint256)
    {
        return CTokenInterface(cTokenAddress).balanceOf(address(this));
    }

    function getBorrowBalance(address cTokenAddress) public returns (uint256) {
        return
            CTokenInterface(cTokenAddress).borrowBalanceCurrent(address(this));
    }
}
