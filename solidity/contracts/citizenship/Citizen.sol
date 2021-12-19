//SPDX-License-Identifier: MIT

// Author: Nithronium

/**
 * This is the main daosman citizenship contract
 * every wallet that is willing to use daosman must be born from 
 * two parents as in real life 
 * in case a child acts bad, parents will be punished
 */

pragma solidity ^0.8.0;

contract Citizen {

    //Could add some more data
    struct CitizenData {
        uint id_;
        uint bornAt_;
        address parentOne_;
        address parentTwo_;
        uint score_;
        bool isJailed_;
        uint penaltyTime_;
    }

    uint256 private _citizenCounter;
    mapping(address=>CitizenData) private _citizens;
    mapping(uint256=>address) private _citizenIds;

    modifier onlyCitizen(address user) {
        require(_citizens[user].bornAt_ != 0,"Not citizen");
        _;
    }

    modifier onlyFreeCitizen(address user) {
        require(_citizens[user].bornAt_ != 0 && _citizens[user].isJailed_ == false,"Citizen jailed");
        _;
    }
    
}