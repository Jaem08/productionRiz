//var ProducteurRole = artifacts.require("../contracts/produitaccesscontrol/ProducteurRole.sol");
//var DistributeurRole = artifacts.require("../contracts/produitaccesscontrol/DistributeurRole.sol");
//var VendeurRole = artifacts.require("../contracts/produitaccesscontrol/VendeurRole.sol");
//var ClientRole = artifacts.require("../contracts/produitaccesscontrol/ClientRole.sol");
//var SupplyChain = artifacts.require("../contracts/winebase//SupplyChain.sol");

/*var ProducteurRole = artifacts.require("./ProducteurRole.sol");
var DistributeurRole = artifacts.require("./DistributeurRole.sol");
var VendeurRole = artifacts.require("./VendeurRole.sol");
var ClientRole = artifacts.require("./ClientRole.sol");
var SupplyChain = artifacts.require("./SupplyChain.sol"); */


//module.exports = function(deployer) {
  //deployer.deploy(ProducteurRole);
  //deployer.deploy(DistributeurRole);
  //deployer.deploy(VendeurRole);
  //deployer.deploy(ClientRole);
  //deployer.deploy(SupplyChain);
//};

 const MyToken = artifacts.require("./ProducteurRole.sol");
 const My = artifacts.require("./DistributeurRole.sol");
 const Token = artifacts.require("./VendeurRole.sol");
 const MyTok = artifacts.require("./ClientRole.sol");
 const TokenSale = artifacts.require("./SupplyChain.sol");
 module.exports = function(deployer) { deployer.deploy(MyToken);
    deployer.deploy(My);
     deployer.deploy(Token);
      deployer.deploy(MyTok);
   deployer.deploy(TokenSale); };


/*module.exports = function(deployer) {
   deployProducteurRole(deployer);
   deployDistributeurRole(deployer);
   deployVendeurRole(deployer);
   deployClientRole(deployer);
   deploySupplyChain(deployer);

};

function deployProducteurRole(deployer) {

   const accounts = web3.eth.accounts;

   const startTime = latestTime();
   const endTime = startTime + duration.days(45);
   const rate = 2500;
   const goal = web3.toWei(250, 'ether');
   const cap = web3.toWei(4000, 'ether');
   const wallet = accounts[0];

   return deployer.deploy(ProducteurRole, startTime, endTime, rate, wallet);

}

function deployDistributeurRole(deployer) {

   const accounts = web3.eth.accounts;

   const startTime = latestTime();
   const endTime = startTime + duration.days(45);
   const rate = 2500;
   const goal = web3.toWei(250, 'ether');
   const cap = web3.toWei(4000, 'ether');
   const wallet = accounts[0];

   return deployer.deploy(DistributeurRole, startTime, endTime, rate, wallet);

}

function deployVendeurRole(deployer) {

   const accounts = web3.eth.accounts;

   const startTime = latestTime();
   const endTime = startTime + duration.days(45);
   const rate = 2500;
   const goal = web3.toWei(250, 'ether');
   const cap = web3.toWei(4000, 'ether');
   const wallet = accounts[0];

   return deployer.deploy(VendeurRole, startTime, endTime, rate, wallet);

}

function deployClientRole(deployer) {

   const accounts = web3.eth.accounts;

   const startTime = latestTime();
   const endTime = startTime + duration.days(45);
   const rate = 2500;
   const goal = web3.toWei(250, 'ether');
   const cap = web3.toWei(4000, 'ether');
   const wallet = accounts[0];

   return deployer.deploy(ClientRole, startTime, endTime, rate, wallet);

}

function deploySupplyChain(deployer) {

   const accounts = web3.eth.accounts;

   const startTime = latestTime();
   const endTime = startTime + duration.days(45);
   const rate = 2500;
   const goal = web3.toWei(250, 'ether');
   const cap = web3.toWei(4000, 'ether');
   const wallet = accounts[0];

   return deployer.deploy(SupplyChain, startTime, endTime, rate, wallet);

}

function latestTime() {
  return web3.eth.getBlock('latest').timestamp;
}

const duration = {
   seconds: function (val) { return val; },
   minutes: function (val) { return val * this.seconds(60); },
   hours: function (val) { return val * this.minutes(60); },
   days: function (val) { return val * this.hours(24); },
   weeks: function (val) { return val * this.days(7); },
   years: function (val) { return val * this.days(365); },
}; */
