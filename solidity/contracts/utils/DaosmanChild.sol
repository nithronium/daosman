//SPDX-License-Identifier: MIT

// Author: Nithronium

pragma solidity ^0.8.0;

import "../access/Roles.sol";

contract DaosmanChild is Roles {

    address private _childrenContract;
    uint256 private _childIndex;
    address private _owner;

    //TODO: add a new ownable contract or adjust roles contract
    constructor () {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner,"not owner");
        _;
    }

    function getChildIndex() public view returns (uint256) {
        return _childIndex;
    }

    function setChildIndex(uint256 newIndex) public onlyOwner returns (bool) {
        _childIndex = newIndex;
        return true;
    }
    
}