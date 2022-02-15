//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface  PriceOracleInterface {
    function getUndelyingPrice(address asset) external view returns(uint);
}
