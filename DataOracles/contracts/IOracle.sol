//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

interface IOracle{
    function getData(bytes32 key) external view returns(bool result, uint date, uint payload);
}