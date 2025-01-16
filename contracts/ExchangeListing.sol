// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ExchangeListings {
    struct Projects {
        string fullName;
        string ticker;
        uint256 price;
        bool trustedTeam;
        bool isVerified;
    }

    Projects public newProject;

    function verifyToken() public returns(bool) {
        if (newProject.trustedTeam == true) {
            newProject.isVerified = true;
            return true;
        } else {
            newProject.isVerified = false;
            return false;
        }
    }

    function ListOnExchnge(/*string memory _fullname, string memory _ticker, uint256 _initialPrice*/) public {
        if (verifyToken()) {
            newProject.isVerified = true;
        } else {
            address(this);
        }
    }
}