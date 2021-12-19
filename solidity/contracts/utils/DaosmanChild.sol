//SPDX-License-Identifier: MIT

// Author: Nithronium

pragma solidity ^0.8.0;

import "../access/Roles.sol";
import "../access/Ownable.sol";

contract DaosmanChild is Roles, Ownable {

    address private _childrenContract;
    uint256 private _childIndex;

    function getChildIndex() public view returns (uint256) {
        return _childIndex;
    }

    function setChildIndex(uint256 newIndex) public onlyOwner returns (bool) {
        _childIndex = newIndex;
        return true;
    }
    
}