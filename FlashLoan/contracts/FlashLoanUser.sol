//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import '../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './FlashLoanprovider.sol';
import './IFlashLoanUser.sol';

contract FlashLoadUser{
    function startFlashLoan(
        address flashLoan,
        uint amount,
        address token
    ) external{
        FlashLoanProvider(flashLoan).executeFlashLoan(address(this), amount, token, bytes(''));
    }
    function flashLoanCallback(
        uint amount, address token, bytes memory data
    )
        external{
        IERC20(token).transfer(msg.sender, amount);
    }
}

