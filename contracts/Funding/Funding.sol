// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * Get funds from users
  * Withdraw gotten funds
   * Specify minimum USD funding value
**/

import { EthConverter } from "./EthConverter.sol";

// Custom error
error Unauthorized();

contract Funding {
    // 
    using EthConverter for uint256;

    // Set to constant(gas efficient) because value is known and never chnages
    uint256 public constant MINIMUM = 5e18;

    address[] public fundersList;

    // Set to immutable(gas efficient) - Never changes once assigned
    address public immutable i_owner;

    // A constructor to define the owner
    constructor() {
        i_owner = msg.sender;
    }
    
    // Link address to amount funded
    mapping(address funder => uint256 fundedAmount) public fundingRecords;

    // Func. to receive and record funding
    function fund() public payable {
        require(msg.value.getPriceUsd() >= MINIMUM, "Not enough ETH sent");

        // Store each funders's address
        fundersList.push(msg.sender);
 
        // Map all donations to addresses
        fundingRecords[msg.sender] = fundingRecords[msg.sender] + msg.value;
        // OR: fundingRecords[msg.sender] += msg.value;
    }

    // Func. to withdraw/clear record of recieved funds
    function withdraw() public ownerOnly{
        
        // Iterate through funders list and clear recorded funds
        for(uint256 idx = 0; idx < fundersList.length; idx++) {
            address funder = fundersList[idx];
            fundingRecords[funder] = 0;
        }
        // Reset all data in fundersList
        fundersList = new address[](0);

        // Using "call": recommended method. Returns status (bool) - gas not fixed
        // Destructure returned data to get status
        (bool callStatus,/*bytes memory returnedData - Not needed here*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callStatus, "Withdrawal Failed");
    }

    // Func. modifier to veirfy owner
    // Parentheses are not required when parameters are not used - used here for consistency
    modifier ownerOnly() {
        // Restric withdrawal to only the owner
        // require(msg.sender == i_owner, "Not authorized to withdraw");

        // Used custom error instead - more gas efficient
        if(msg.sender != i_owner) {
            revert Unauthorized();
        }
         _;
    }
}

/*
        3 ways to send/withdraw ether:

        1. send
        2. transfer
        3. call
        */

        // using "send": Returns status (bool) - 2300 gas max 
        // Send all balance of current contract to func caller
        // bool sendStatus = payable(msg.sender).send(address(this).balance);
        // require(sendStatus, "Failed to send");

        // Using "transfer": Reverts when failed. 2300 gas max
        // transfer all balance of current contract to func caller
        // payable(msg.sender).transfer(address(this).balance);