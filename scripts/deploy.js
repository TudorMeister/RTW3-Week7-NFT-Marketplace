const { ethers } = require("hardhat");
const hre = require("hardhat");
const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();
  const balance = await deployer.getBalance();
  const Marketplace = await hre.ethers.getContractFactory("NFTMarketplace");
  const marketplace = await Marketplace.deploy();

  await marketplace.deployed();

  const data = {
    address: marketplace.address,
    abi: JSON.parse(marketplace.interface.format('json'))
  }

  //This writes the ABI and address to the mktplace.json
  fs.writeFileSync('./src/Marketplace.json', JSON.stringify(data))

  const Reward = await hre.ethers.getContractFactory("NFTMarketplaceReward");
  const reward = await Reward.deploy();

  await reward.deployed();

  const data2 = {
    address: reward.address,
    abi: JSON.parse(reward.interface.format('json'))
  }

  //This writes the ABI and address to the reward.json
  fs.writeFileSync('./src/Reward.json', JSON.stringify(data2))


}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
