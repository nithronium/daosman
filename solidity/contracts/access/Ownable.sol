//SPDX-License-Identifier: MIT

// Author: Nithronium

/**
 * Instead of re-implementing owner stuff all the time
 * i better implement it here once
 * the owner should also be able to change depending on the 
 * community votes but I can implement it on v2
 */

pragma solidity ^0.8.0;

contract Ownable {

    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(_owner == msg.sender,"Not owner");
        _;
    }

    function getOwner() public view returns (address) {
        return _owner;
    }

    function setOwner(address newOwner) public onlyOwner {
        _owner = newOwner;
    }
    
}