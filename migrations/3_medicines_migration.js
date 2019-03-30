var Medicines = artifacts.require("./Medicines.sol");

module.exports = function(deployer) {
  deployer.deploy(Medicines);
};