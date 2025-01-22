// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import { ProjectPrep } from "./ProjectPrep.sol";

contract OptimisedListing {
    // Map Token identifier to new ProjectPrep instance
    mapping(string => ProjectPrep) public newProjects;

    // Array to store listed tokens
    ProjectPrep.Project[] public listedProjects;

    function addNewToken(string memory _projectName, string memory _ticker, uint256 _price, bool _trustedTeam) public {
        // Create new ProjectPrep instance with desired param
        // Visibility modifiers not allowed - not needed
        ProjectPrep newProjectPrep = new ProjectPrep(_projectName, _ticker, _price, _trustedTeam);

        // Map token symbol (ticker) to its ProjectPrep instance
        newProjects[_ticker] = newProjectPrep;
    }

    function viewToken(string memory _ticker) public view returns(ProjectPrep.Project memory) {
        // Check if token exists
        require(address(newProjects[_ticker]) != address(0), "Token not found");

        // Get token by symbol, then get its details
        return newProjects[_ticker].getProjectDetails();
    }

    // Function to Verify and list a token by symbol
    // Added 'virtual' keyword so that func can be overidden
    function listToken(string memory _ticker) public virtual {
        // Check if token exists
        require(address(newProjects[_ticker]) != address(0), "Token not found");

        // verify if token is trustworthy
        bool verify = newProjects[_ticker].verifyToken();
        require(verify, "Token not trustworthy enough to be listed");

        // Add token to array of listed tokens
        listedProjects.push(newProjects[_ticker].getProjectDetails());
    }
}