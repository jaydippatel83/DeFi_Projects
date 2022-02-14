//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./IFlashLoanUser.sol";

contract FlashLoanProvider is ReentrancyGuard {
    mapping(address => IERC20) public tokens;

    constructor(address[] memory _tokens) {
        for (uint256 i = 0; i < _tokens.length; i++) {
            tokens[_tokens[i]] = IERC20(_tokens[i]);
        }
    }

    function executeFlashLoan(
        address callback,
        uint256 amount,
        address _token,
        bytes memory data
    ) nonReentrant() external {
        IERC20 token = tokens[_token];
        uint256 originalBalance = token.balanceOf(address(this));
        require(address(token) != address(0), "Token not supported");
        require(originalBalance >= amount, "Amount too high");
        token.transfer(callback, amount);
        IFlashLoanUser(callback).flashLoancallBack(amount, _token, data);
        require(token.balanceOf(address(this))== originalBalance,"flashloan not reimbursed");
    }
}
