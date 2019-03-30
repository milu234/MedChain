var OrderProcess = artifacts.require("./OrderProcess.sol");

module.exports = function(deployer) {
  deployer.deploy(OrderProcess);
};