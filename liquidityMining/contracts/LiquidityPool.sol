//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./UnderLayingToken.sol";
import "./LpToken.sol";
import "./GovtToken.sol";

contract LiquidityPool is LpToken {
    mapping(address => uint256) public checkpoints;
    UndelyingToken public underlyingToken;
    GovtToken public govtToken;
    uint256 public constant REWARD_PER_BLOCK = 1;

    constructor(address _underlyingToken, address _govtToken) {
        underlyingToken = UndelyingToken(_underlyingToken);
        govtToken = GovtToken(_govtToken);
    }
    function deposit(uint amount) external{
        if(checkpoints[msg.sender] == 0){
            checkpoints[msg.sender] = block.number;
        }
        _distributeRewards(msg.sender);
        underlyingToken.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount);  
    }

    function withdraw(uint amount) external{
        require( balanceOf(msg.sender) >= amount ,"Not Enough Lp Token");
        _distributeRewards(msg.sender);
        underlyingToken.transfer(msg.sender, amount);
        _burn(msg.sender, amount);
    }

    function _distributeRewards(address benificiary) internal{
        uint checkpoint = checkpoints[benificiary];
        if(block.number - checkpoint > 0){
            uint distriutionAmount = balanceOf(benificiary) * (block.number - checkpoint) * REWARD_PER_BLOCK;
            govtToken.mint(benificiary, distriutionAmount);
            checkpoints[benificiary] = block.number; 
        }
    }
}
