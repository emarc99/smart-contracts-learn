// const hre = require("hardhat");
// const { ethers } = require("hardhat");
// // const { MerkleTree } = require("merkletreejs");
// // const keccak256 = require("keccak256");

// // // leaves = participants.map(p => keccak256(ethers.utils.solidityPack(["address", "uint256"], [p.address, p.amount])));
// // // merkleTree = new MerkleTree(leaves, keccak256, { sortPairs: true });
// // // root = merkleTree.getRoot();


// // const tokenAddress = "0x8682af8dd55D85D96644721827F0fa26eFC6f3B1";
// // const merkleRoot = "6b97a48c2de43f662e3735eb7efdefafe60d7fabdff6b14b413957701afb7b87";
// // const bytes32Value = ethers.hexlify(merkleRoot);

// async function main() {
// //   const CircleAreaCalculator = await hre.ethers.getContractFactory("MerkleAirdrop");
// //   const calculator = await CircleAreaCalculator.deploy(tokenAddress, bytes32Value);

// //   // await calculator.deployed();

// //   console.log("CircleAreaCalculator deployed to:", calculator.target);
// // }



// const [deployer] = await ethers.getSigners();

// console.log("Deploying contracts with the account:", deployer.address);

// const MerkleAirdrop = await ethers.getContractFactory("MerkleAirdrop");

// const tokenAddress = "0x8682af8dd55D85D96644721827F0fa26eFC6f3B1";
// const merkleRoot = "0x6b97a48c2de43f662e3735eb7efdefafe60d7fabdff6b14b413957701afb7b87"; // Replace with your generated Merkle root

// const airdrop = await MerkleAirdrop.deploy(tokenAddress, merkleRoot);

// console.log("MerkleAirdrop contract deployed to:", airdrop.target);

// }
///////////

// async function main() {
//     // We get the contract to deploy
//     const Multisig = await hre.ethers.getContractFactory("MultiSigWallet");
  
//     // Quorum and the list of valid signers (replace with actual addresses)
//     const quorum = 2;
//     const validSigners = [
//       "0x8682af8dd55D85D96644721827F0fa26eFC6f3B1",
//       "0xA1fe60E291dc6B1153Adae0d567859Eb5294Fd05"
//     ];
  
//     const multisig = await Multisig.deploy(quorum, validSigners);
  
   
  
//     console.log("Multisig deployed to:", multisig.target);
//   }


async function main() {
    const MultisigFactory = await ethers.getContractFactory("CustomNFT");
    const factory = await MultisigFactory.deploy();
    
    console.log("MultisigFactory deployed to:", factory.target);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
