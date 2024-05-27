const dotenv = require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');



module.exports = {
  contracts_build_directory: './build',

  compilers: {
    solc: {
      version: "0.8.10",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200, // 999999,
        },
      },
    },
  },

  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      gasPrice: 100000000000, // 100 gwei
      skipDryRun: true,
      production: false,
    },

    mainnet: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, `wss://eth-mainnet.alchemyapi.io/v2/${process.env.API_ALCHEMY}`
      ),
      network_id: 1,
      gas: 1000000,
      gasPrice: 15000000000, // 100 gwei
      // from: <address>,        // Account to send txs from (default: accounts[0])
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true,
      production: true,
    },

    rinkeby: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, `wss://eth-rinkeby.alchemyapi.io/v2/${process.env.API_ALCHEMY}`
      ),
      network_id: 4,
      gas: 6000000,
      confirmations: 1,
      timeoutBlocks: 2000,
      skipDryRun: true,
      production: false,
    },
  },

  plugins: [
    'truffle-plugin-verify'
  ],

  api_keys: {
    etherscan: process.env.API_ETHERSCAN,
  },

  mocha: {
    // timeout: 100000,
  },

  db: {
    enabled: false,
  },
};
