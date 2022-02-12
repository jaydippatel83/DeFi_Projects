//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11; 
import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ContractB {
    function deposit(uint tokenId) external;
    function withdraw(uint tokenId) external; 
}

contract ContractA {
    IERC721 public token;
    ContractB public contractB;

    constructor(address _token, address _contractB) {
        token = IERC721(_token);
        contractB = ContractB(_contractB);
    }

    function deposit(uint256 tokenId) external {
        token.safeTransferFrom(msg.sender, address(this), tokenId);
        token.approve(address(contractB), tokenId);
        contractB.deposit(tokenId);
    }

    function withdraw(uint256 tokenId) external {
        contractB.withdraw(tokenId);
        token.safeTransferFrom(address(this),msg.sender, tokenId);
    }
}
