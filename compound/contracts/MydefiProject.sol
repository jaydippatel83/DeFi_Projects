//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CTokenInterface.sol";
import "./ComptrollerInterface.sol";
import "./PriceOracleInterface.sol";

contract MyDeFiProject {
    ComptrollerInterface public comptroller;
    PriceOracleInterface public priceOracle;

    constructor(address _comptroller, address _priceOracle) {
        comptroller = ComptrollerInterface(_comptroller);
        priceOracle = PriceOracleInterface(_priceOracle);
    }

    function supply(address cTokenAddress, uint256 underlyingAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.mint(underlyingAmount);
        require(result == 0, "cTokrn#mint Failed. see compound errorReported");
    }

    function redeem(address cTokenAddress, uint256 cTokenAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        uint256 result = cToken.redeem(cTokenAmount);
        require(
            result == 0,
            "cTokrn#redeem() Failed. see compound errorReported"
        );
    }

    function enterMarket(address cTokenAddress) external {
        address[] memory markets = new address[](1);
        markets[0] = cTokenAddress;
        uint256[] memory result = comptroller.etherMarkets(markets);
        require(
            result[0] == 0,
            "comptroller#etherMarkets() Failed. see compound errorReported"
        );
    }

    function borrow(address cTokenAddress, uint256 borrowAmount) external {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        uint256 result = cToken.borrow(borrowAmount);
        require(
            result == 0,
            "cToken#borrow() Failed. see compound errorReported"
        );
    }

    function repayBorrow(address cTokenAddress, uint256 underlyingAmount)
        external
    {
        CTokenInterface cToken = CTokenInterface(cTokenAddress);
        address underlyingAddress = cToken.underlying();
        IERC20(underlyingAddress).approve(cTokenAddress, underlyingAmount);
        uint256 result = cToken.repayBorrow(underlyingAmount);
        require(
            result == 0,
            "cTokrn#repayBorrow() Failed. see compound errorReported"
        );
    }

    function getMaxBorrow(address cTokenAddress)
        external
        view
        returns (uint256)
    {
        (uint256 result, uint256 liquidity, uint256 shortfall) = comptroller
            .getAccountLiquidity(address(this));
        require(
            result == 0,
            "comptroller#getAccountLiquidity() Failed. see compound errorReported"
        );
        require(shortfall == 0, "Account underwater");
        require(liquidity > 0, "Account does not have collateral");
        uint256 underlyingPrice = priceOracle.getUndelyingPrice(cTokenAddress);
        return liquidity / underlyingPrice;
    }
}
