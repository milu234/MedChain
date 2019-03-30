var OrderWholesaler = artifacts.require("./OrderWholesaler.sol");

module.exports = function(deployer) {
  deployer.deploy(OrderWholesaler);
};