//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '../node_modules/@openzeppelin/contracts/access/Ownable.sol';

contract GovtToken is ERC20,Ownable{
    constructor() ERC20('Governance Token','GKT') Ownable(){}

    function mint(address to, uint amount) external onlyOwner(){
        _mint(to, amount);
    } 
}