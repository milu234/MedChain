var UserInfo = artifacts.require("./UserInfo.sol");

module.exports = function(deployer) {
  deployer.deploy(UserInfo);
};