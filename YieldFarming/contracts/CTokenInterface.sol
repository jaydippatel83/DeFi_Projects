//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface CTokenInterface {
    function mint(uint256 minAmount) external returns (uint256);

    function redeem(uint256 redeemTokens) external returns (uint256);

    function borrow(uint256 borrowAmount) external returns (uint256);

    function repayBorrow(uint256 repayAmount) external returns (uint256);

    function borrowBalanceCurrent(address account) external returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function underlaying() external view returns (address);
}
