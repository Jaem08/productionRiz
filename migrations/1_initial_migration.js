var Migrations = artifacts.require("./Migrations.sol");

//const Migrations = artifacts.require("Migrations");
//const rate = 2500;
//const wallet = accounts[0];

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
