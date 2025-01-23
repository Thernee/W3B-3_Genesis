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
    function fund() public payable {
        require(msg.value >= 1e17, "Not enough ETH sent");
    }

    function getETHPrice() public view returns(uint256) {
        // ETH/Sepolia address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface datafeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = datafeed.latestRoundData();
        return uint256(price);

    }

    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}