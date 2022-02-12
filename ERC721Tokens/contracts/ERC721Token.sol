//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Token is ERC721 {
    constructor() ERC721("JD Token", "JDP") {}
}

contract ERC721Token1 is ERC721 {
    constructor() ERC721("JD Token", "JDP") {
        _safeMint(msg.sender, 0);
    }
}

contract ERC721Token2 is ERC721 {
    address public admin;

    constructor() ERC721("JD Token", "JDP") {
        admin = msg.sender;
    }

    function mint(address to, uint256 tokenId) external {
        require(msg.sender == admin, "only admin");
        _safeMint(to, tokenId);
    }
}

contract ERC721Token3 is ERC721 {
    constructor() ERC721("JD Token", "JDP") {}

    function faucet(address to, uint256 tokenId) external {
        _safeMint(to, tokenId);
    }
}
