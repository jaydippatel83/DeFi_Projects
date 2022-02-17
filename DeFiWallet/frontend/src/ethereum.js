import { ethers, Contract } from 'ethers';
import Wallet from './contracts/Wallet.json';
import addresses from './addresses';

const getBlockchain = () =>
  new Promise((resolve, reject) => {
    window.addEventListener('load', async () => {
      if(window.ethereum) {
        await window.ethereum.enable();
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();

        const wallet = new Contract(
         '0x99F2d97E207Afa114A8D51c4bf5e5Ae94E7b9110',
          Wallet.abi,
          signer
        );

        const dai = new Contract(
          addresses.dai,
          ['function approve(address spender, uint amount) external'],
          signer
        );

        resolve({signer, wallet, dai});
      }
      resolve({signer: undefined, wallet: undefined, dai: undefined});
    });
  });

export default getBlockchain;
