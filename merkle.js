// import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
// import fs from "fs";
// import csv from "csv-parser";

// const values = [];
// fs.createReadStream("airdrop.csv")
//   .pipe(csv())
//   .on("data", (row) => {
//     values.push([row.address, row.amount]);
//   })
//   .on("end", () => {
//     const tree = StandardMerkleTree.of(values, ["address", "uint256"]);
//     console.log("Merkle Root:", tree.root);
//     fs.writeFileSync("tree.json", JSON.stringify(tree.dump()));
//   });

// const tree = StandardMerkleTree.load(
//   JSON.parse(fs.readFileSync("tree.json", "utf8"))
// );
// const treee = StandardMerkleTree.load(
//   JSON.parse(fs.readFileSync("tree.json", "utf8"))
// );
// for (const [i, v] of tree.entries()) {
//   if (v[0] === "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4") {
//     const proof = tree.getProof(i);
//     console.log("Proof:", proof);
//   }
// }


const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');
const fs = require('fs');
const csv = require('csv-parser');

// Function to hash an entry (address and amount)
function hashEntry(address, amount) {
  return keccak256(address + amount);
}

// Read CSV file and generate Merkle Tree
function generateMerkleTree(filePath) {
  const entries = [];

  // Read CSV file
  fs.createReadStream(filePath)
    .pipe(csv())
    .on('data', (row) => {
      const { address, amount } = row;
      const hashedEntry = hashEntry(address, amount);
      entries.push(hashedEntry);
    })
    .on('end', () => {
      // Build Merkle Tree
      const merkleTree = new MerkleTree(entries, keccak256, { sortPairs: true });
      
      // Get the Merkle root
      const merkleRoot = merkleTree.getRoot().toString('hex');
      console.log('Merkle Root:', merkleRoot);

      // Optionally, output the tree and root to a file
      fs.writeFileSync('merkle-root.txt', merkleRoot);
      console.log('Merkle Root saved to merkle-root.txt');
    });
}

// Run the script by specifying the CSV file path
const filePath = 'airdrop.csv'; // Path to your CSV file
generateMerkleTree(filePath);

