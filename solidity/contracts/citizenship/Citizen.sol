//SPDX-License-Identifier: MIT

// Author: Nithronium

/**
 * This is the main daosman citizenship contract
 * every wallet that is willing to use daosman must be born from 
 * two parents as in real life 
 * in case a child acts bad, parents will be punished
 */

pragma solidity ^0.8.0;

import "../access/Roles.sol";

contract Citizen is Roles {

    //Could add some more data
    struct CitizenData {
        uint id_;
        uint bornAt_;
        address parentOne_;
        address parentTwo_;
        uint score_;
        bool isJailed_;
        uint penaltyTime_;
        uint childCount_;
    }

    struct CitizenshipNominations {
        address parentOne_;
        address parentTwo_;
        bool parentOneSigned_;
        bool parentTwoSigned_;
    }

    uint256 private _citizenCounter;
    mapping(address=>CitizenData) private _citizens;
    mapping(uint256=>address) private _citizenIds;

    mapping(address=>CitizenshipNominations) private _nominations;

    uint private _allowedChildCount;

    event CitizenshipGranted(address user, address parentOne, address parentTwo, uint birthdate);
    event UserNominated(address user, address nominatedBy, uint nominationDate);
    event ParentConsented(address child, address parent, uint consentDate);

    modifier onlyCitizen(address user) {
        require(_citizens[user].bornAt_ != 0,"Not citizen");
        _;
    }

    modifier onlyFreeCitizen(address user) {
        require(_citizens[user].bornAt_ != 0 && _citizens[user].isJailed_ == false,"Citizen jailed");
        _;
    }

    modifier birthControl(address parent) {
        require(_citizens[parent].childCount_ <= _allowedChildCount,"Already too many children");
        _;
    }

    constructor() {
        registerRole('DICTATOR', false, true);
        _allowedChildCount = 5;
        grantCitizenship(msg.sender);
    }

    function grantCitizenship(address user) onlyRole('DICTATOR') public returns (bool) {
        require(!isCitizen(user),"User already a citizen");
        _citizens[user].id_ = _citizenCounter;
        _citizens[user].bornAt_ = block.timestamp;
        _citizens[user].parentOne_ = msg.sender;
        _citizens[user].parentTwo_ = address(0);
        _citizens[user].score_ = 100000000000000000000;
        _citizens[user].isJailed_ = false;
        _citizens[user].penaltyTime_ = 0;

        _citizenIds[_citizenCounter] = user;
        _citizenCounter++;

        emit CitizenshipGranted(user,msg.sender,address(0),block.timestamp);

        return true;
    }

    function nominateCitizen(address user) onlyFreeCitizen(msg.sender) public returns (bool) {

    }

    function consentBirth(address user) birthControl(msg.sender) onlyFreeCitizen(msg.sender) public returns (bool) {

    }
    
    // INTERNAL FUNCTIONS // 
    function isCitizen(address user) public view returns (bool) {
        if(_citizens[user].bornAt_ == 0) { return true; } 
        return false;
    }
}