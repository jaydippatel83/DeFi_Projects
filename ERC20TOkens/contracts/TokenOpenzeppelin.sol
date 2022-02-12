//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenOpenzeppelin1 is ERC20 {
    constructor() ERC20("JD Token", "JDP") {}
}

contract TokenOpenzeppelin2 is ERC20 {
    constructor() ERC20("JD Token", "JDP") {
        _mint(msg.sender, 100000);
    }
}

contract TokenOpenzeppelin3 is ERC20 {
    address public admin;

    constructor() ERC20("JD Token", "JDP") {
        admin = msg.sender;
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only Admin");
        _mint(to, amount);
    }
}

contract TokenOpenzeppelin4 is ERC20 { 
    constructor() ERC20("JD Token", "JDP") { 
    }

    function faucet(address to, uint256 amount) external { 
        _mint(to, amount);
    }
}
