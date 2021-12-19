//SPDX-License-Identifier: MIT

// Author: Nithronium

/**
 * I want this children contract to keep track of the 
 * child contracts of daosman, here anyone 
 * will be able to register a smart contract to be used with the 
 * daosman
 *
 * make sure to include the interfaces of the children contracts on the
 * directory
 */

pragma solidity ^0.8.0;

import "./access/Roles.sol";

contract Children is Roles {

    struct ChildrenData {
        bool isRegistered_;
        bool isPublic_;
        bool isOwnable_;
        address owner_;
    }

    uint256 private _childrenCounter;
    mapping(address=>ChildrenData) private _children;
    mapping(uint256=>address) private _childrenIds;

    function registerChild(address at, bool isPublic, bool isOwnable) public returns (bool) {
        require(!childExists(at),"Child already registered");

        _children[at].isRegistered_ = true;
        _children[at].isPublic_ = isPublic;
        _children[at].isOwnable_ = isOwnable;
        if(isOwnable) { _children[at].owner_ = msg.sender; } else { _children[at].owner_ = address(0); }

        return true;
    }

    function childExists(address at) public view returns (bool) {
        return _children[at].isRegistered_;
    }

    
}