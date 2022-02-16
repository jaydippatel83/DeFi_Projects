//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface CEthInterface {
    function mint() external payable;

    function redeemUnderlying(uint256 redeemAmount)
        external
        view
        returns (uint256);

    function balanceOfUnderlying(address owner) external returns (uint256);
}
