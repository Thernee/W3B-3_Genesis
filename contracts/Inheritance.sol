// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
 * Implementing inheritance and function overloading
 * 
 * NB: Func name and param have to be same (Param type and number) for overloading to happen
  * -- Override happens even in cases of funcs with diff. returns or or visibility modifiers
*/

// Import OptimisedListing contract 
import { OptimisedListing } from "./OptimisedListing.sol";

// Create child contract to inherit OptimisedListing 
contract Inheritance is OptimisedListing {

    event SucessfulExecution(address indexed caller, string message);

    // Overide func from OptimisedListing - Add mesage when func executes
    function listToken(string memory _ticker) public override {
        super.listToken(_ticker);
        emit SucessfulExecution(msg.sender, "Token Successfully Listed");
    }
}