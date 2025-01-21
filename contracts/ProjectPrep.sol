// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract ProjectPrep {
    struct Project {
        string projectName;
        string ticker;
        uint256 price;
        bool trustedTeam;
        bool isVerified;
    }

    Project public newProject; //Avoid direct access from outside

    //Initialize project to deploy
    constructor(string memory _projectName, string memory _ticker, uint256 _price, bool _trustedTeam) {
        // Initialize new instance of Project
        newProject = Project(_projectName, _ticker, _price, _trustedTeam, false);

        // newProject.projectName = _projectName;
        // newProject.ticker = _ticker;
        // newProject.price = _price;
        // newProject.trustedTeam = _trustedTeam;
        // newProject.isVerified = false; // Project initially not verified
    }

    // Verify new projects
    function verifyToken() public returns(bool) {
        // Verify project if team is trusted
        newProject.isVerified = newProject.trustedTeam;
        return newProject.isVerified; // return verification result
    }

    // function getProjectDetails() public view returns(string memory, string memory, uint256, bool, bool) {
        function getProjectDetails() public view returns(Project memory) {
            return newProject;
        // return (
        //     newProject.projectName,
        //     newProject.ticker,
        //     newProject.price,
        //     newProject.trustedTeam,
        //     newProject.isVerified
        // );
    }
}

// // List new projects on exchange
//     function ListToken() public {
//         bool verify = verifyToken();
//         require(verify, "Only verified tokens can be listed");
//     }
