//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11; 

import './IOracle.sol';

contract Consumer{
    IOracle public oracle;

    constructor(address _oracle){
        oracle = IOracle(_oracle);
    }
    function foo()external{
        bytes32 key = keccak256(abi.encodePacked('BTC/INR'));
        (bool result , uint timestamp, uint data) = oracle.getData(key);
        require( result == true,"could not get price");
        require( timestamp >= block.timestamp - 2 minutes, "price to Old"); 
    }
}