//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface CTokenInterface {
    function mint(uint256 mintAmmount) external returns (uint256);

    function redeem(uint256 redeemTokens) external returns (uint256);

    function redeemUnderlying(uint256 redeemAmount) external returns (uint256);

    function borrow(uint256 borrowAmmount) external returns (uint256);

    function repayBorrow(uint256 repayTokens) external returns (uint256);

    function underlying() external view returns (address);
}
