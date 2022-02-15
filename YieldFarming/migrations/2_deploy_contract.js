const YieldFarmer = artifacts.require("YieldFarmer");

module.exports = function (deployer) {
  deployer.deploy(YieldFarmer);
};
