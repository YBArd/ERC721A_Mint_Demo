require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-web3");

const ALCHEMY_API_KEY = "wkSjccKL39m8n1m47SvW_8fyERGoxWKO";

const RINKEBY_PRIVATE_KEY = "134095c0deedaa97bce187fdf9c23a18f43e642ad3130c37820b8ad4f171b898";

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.13",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/wkSjccKL39m8n1m47SvW_8fyERGoxWKO',
      accounts: ['134095c0deedaa97bce187fdf9c23a18f43e642ad3130c37820b8ad4f171b898']
    }
  }
};
