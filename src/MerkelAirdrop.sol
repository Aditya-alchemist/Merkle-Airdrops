// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20, SafeERC20 } from "../lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "../lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";

contract MerkelAirdrop{
     using SafeERC20 for IERC20;
    bytes32 private immutable i_merkleRoot;
    IERC20 private immutable i_airdroptoken;
    address[] claimers;
    mapping(address claimer => bool hasclaimed) private s_claimed;
    event claimamount(address indexed account, uint256 amount);
    error MerkleAirdrop_InvalidProof();
    error MerkleAirdrop_AlreadyClaimed();
    constructor (bytes32 merkleRoot, IERC20 airdroptoken){
      i_merkleRoot = merkleRoot;
        i_airdroptoken = airdroptoken;
    }

    function claim(address account, uint256 amount , bytes32[] calldata merkleProof) external {
        if(s_claimed[account]){
            revert MerkleAirdrop_AlreadyClaimed();
        }
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        if(!MerkleProof.verify(merkleProof, i_merkleRoot, leaf)){
            revert MerkleAirdrop_InvalidProof();
        }
         s_claimed[account] = true;
       emit  claimamount(account, amount);
       i_airdroptoken.safeTransfer(account, amount);
       s_claimed[account] = true;
    }

    function getMerkleRoot() external view returns (bytes32){
        return i_merkleRoot;
    }

    function getAirdropToken() external view returns (IERC20){
        return i_airdroptoken;
    }
}

