// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


import {Test,console} from "forge-std/Test.sol";
import {MerkelAirdrop} from "../src/MerkelAirdrop.sol";
import {BagelToken} from "../src/BagelToken.sol";


contract MerkleAirdropTest is Test{
    MerkelAirdrop public Airdrop;
    BagelToken public token;
    bytes32 public merkleRoot = 0xfba4401795c371e44a8b8932031439edf0627655a1e69b8eeb1edc10048b9461;
    uint256 public amounttoclaim = 25* 1e18;
      bytes32 proofOne = 0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a;
    bytes32 proofTwo = 0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576;
    bytes32[] proof = [proofOne, proofTwo];
    
    address user;
    uint256 privKey;

    function setUp() public {
        token = new BagelToken();
        
        Airdrop = new MerkelAirdrop(merkleRoot, token);
        (user, privKey) = makeAddrAndKey("user");
    }
    function TestUsersCanClaimAirdrop() public{
       uint256 startingbalance= token.balanceOf(user);
       vm.prank(user);
       Airdrop.claim(user, amounttoclaim, proof);
    }
}

