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
    bytes32[] public proof = [];
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
       airdrop.claim(user, amounttoclaim, proof);
    }
}

