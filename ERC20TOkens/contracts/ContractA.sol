//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ContractB {
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external; 
}

contract ContractA {
    IERC20 public token;
    ContractB public contractB;

    constructor(address _token, address _contractB) {
        token = IERC20(_token);
        contractB = ContractB(_contractB);
    }

    function deposit(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
        token.approve(address(contractB), amount);
        contractB.deposit(amount);
    }

    function withdraw(uint256 amount) external {
        contractB.withdraw(amount);
        token.transfer(msg.sender, amount);
    }
}
