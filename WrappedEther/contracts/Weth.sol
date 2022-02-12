//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import '../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Weth is ERC20{
    constructor() ERC20("Wrapped Ether","WETH"){}

    function deposit()external payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(balanceOf(msg.sender) >= amount,"Balance too low");
        _burn(msg.sender, amount);
        payable(msg.sender).transfer(amount);
    }
}

