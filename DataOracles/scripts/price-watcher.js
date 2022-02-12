const CoinGecko = require('coingecko-api');
const Oracle = artifacts.require('Oracle.sol');

const POLL_INTERVAL = 5000; //5s
const CoinGeckoClient = new CoinGecko();

module.exports = async done => {
  const [_, reporter] = await web3.eth.getAccounts();
  const oracle = await Oracle.deployed();

  while(true) {
    const response = await CoinGeckoClient.coins.fetch('bitcoin', {});
    let currentPrice = parseFloat(response.data.market_data.current_price.inr);
    currentPrice = parseInt(currentPrice);
    await oracle.updateData(
      web3.utils.soliditySha3('BTC/INR'), 
      currentPrice,
      {from: reporter}
    ); 
    console.log(`new price for BTC/INR ${currentPrice.toFixed(2)} updated on-chain`);
    await new Promise((resolve, _) => setTimeout(resolve, POLL_INTERVAL)); 
  }

  done();
}