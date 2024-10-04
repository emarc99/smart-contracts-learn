// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MerkleAirdrop {
    address owner;
    address public tokenAddress;
    bytes32 public merkleRoot;


    event ClaimSuccessful();
    
    constructor(address _tokenAddress, bytes32 _merkleRoot) {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
        merkleRoot = _merkleRoot;
    }
    mapping(address => bool) public hasClaimed;

    function verifyClaim(
        bytes32[] memory proof,
        uint256 amount
    ) public {
        
        require(!hasClaimed[msg.sender], "Airdrop already claimed.");
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(msg.sender, amount))));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");
        
        hasClaimed[msg.sender] = true;
    
        IERC20(tokenAddress).transfer(msg.sender, amount);
       emit ClaimSuccessful();
    }

}