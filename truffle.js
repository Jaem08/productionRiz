require('babel-register')
var HDWalletProvider = require('truffle-hdwallet-provider');

const mnemonic = 'behave long satisfy cube evidence cloud loan hurry tribe peasant funny diagram';
//const mnemonic = 'aim consider north pig logic siren sugar gas term try alcohol flower';
//const infura = 'https://rinkeby.infura.io/v3/b849c86a78784e47bbe4c7ca57f8f222'
const infura = 'https://rinkeby.infura.io/v3/3e66bbd529f04e49b75f3b70fa8a07be'
module.exports = {

/*  compilers: {
    solc: {
      version: "^0.4.23",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
          },
      }
    }
  }, */


  //module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    }
  },
  ropsten: {
    network_id: 3,
    host: "127.0.0.1",
    port: 7545,
    gas: 9900000
  },  rinkeby: {
      provider: () => new HDWalletProvider(mnemonic, infura),
      network_id: 4,
      gas: 6700000,
      gastPrice : 100000000000
    },
    solc: {
        optimizer: {
            enabled: true,
            runs: 200
        }
    }
};


/*
    networks: {

      development: {
        host: "127.0.0.1",
        port: 7545,
        gas: 6700000,
        //network_id: "5777" // Match any network id
        network_id: "*" // Match any network id
      },
      ,
      ropsten: {
        network_id: 3,
        host: "127.0.0.1",
        port: 7545,
        gas: 9900000
      }


      */








  /*    ropsten: {
     host: 'localhost',
     port: 7545,
     gas: 6700000,
     network_id: '3' // Match any network id
   },
   kovan: {
     host: 'localhost',
     port: 7545,
     gas: 6700000,
     network_id: '5' // Match any network id
   },
   mocha: {
     enableTimeouts: false
   }

    },
  };  */
