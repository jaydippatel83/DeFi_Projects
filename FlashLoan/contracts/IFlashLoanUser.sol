//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IFlashLoanUser {
    function flashLoancallBack(uint amount , address token, bytes memory data) external;
}