// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { ProjectPrep } from "./ProjectPrep.sol";

contract ProjectListing {
    ProjectPrep public projectPrep = new ProjectPrep("Bitcoin", "$BTC", 45000, true);
    
    function viewTokens() public view returns(ProjectPrep.Project memory){
        return projectPrep.getProjectDetails();
    }

    ProjectPrep.Project[] public listedProjects;

    function listToken() public {
        bool verify = projectPrep.verifyToken();
        require(verify, "Token Not Trustworthy enough to be listed");

        listedProjects.push(projectPrep.getProjectDetails());
    }
}