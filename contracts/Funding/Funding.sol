// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * Get funds from users
  * Withdraw gotten funds
   * Specify minimum USD funding value
**/

// Import AggregatorV3Interface interface
import { AggregatorV3Interface } from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract Funding {
    uint256 minimum = 5e18;
    address[] public fundersList;
    mapping(address funder => uint256 fundedAmount) fundingRecords;

    // Func. to receive and record funding
    function fund() public payable {
        require(getPriceUsd(msg.value) >= minimum, "Not enough ETH sent");

        // Store each funders's address
        fundersList.push(msg.sender);

        // Map all donations to addresses
        fundingRecords[msg.sender] = fundingRecords[msg.sender] + msg.value;
    }

    // Get current, real-world ETH price in terms of wei
    function getETHPrice() public view returns(uint256) {
        // ETH/Sepolia address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface datafeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // Destructure and get only price from the returned data
        // Price is returned with 8 decimals
        (,int256 price,,,) = datafeed.latestRoundData();

        // Add 10 decimals to standardize (ETH in wei) the price to 18 decimal places (8 + 10)
        return uint256(price * 1e10);
    }

    // Get ETH price in USD
    function getPriceUsd(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getETHPrice();
        uint256 priceUsd = (ethAmount * ethPrice) / 1e18;
        return priceUsd;
    }
    
    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}