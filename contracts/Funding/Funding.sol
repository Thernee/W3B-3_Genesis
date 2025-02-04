// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * Get funds from users
  * Withdraw gotten funds
   * Specify minimum USD funding value
**/

import { EthConverter } from "./EthConverter.sol";

contract Funding {
    // 
    using EthConverter for uint256;

    uint256 minimum = 5e18;

    address[] public fundersList;
    
    // Link address to amount funded
    mapping(address funder => uint256 fundedAmount) public fundingRecords;

    // Func. to receive and record funding
    function fund() public payable {
        require(msg.value.getPriceUsd() >= minimum, "Not enough ETH sent");

        // Store each funders's address
        fundersList.push(msg.sender);
 
        // Map all donations to addresses
        fundingRecords[msg.sender] = fundingRecords[msg.sender] + msg.value;
        // OR: fundingRecords[msg.sender] += msg.value;
    }

    // Func. to withdraw/clear record of recieved funds
    function clearFunding() public {
        // Iterate through funders list and clear recorded funds
        for(uint256 idx = 0; idx < fundersList.length; idx++) {
            address funder = fundersList[idx];
            fundingRecords[funder] = 0;
        }
    }
}