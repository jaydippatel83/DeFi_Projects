//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface ComptrollerInterface {
    function etherMarkets(address[] calldata cTokens)
        external
        returns (uint256[] memory);

    function getAccountLiquidity(address owner)
        external
        view
        returns (
            uint256,
            uint256,
            uint256
        );
}
