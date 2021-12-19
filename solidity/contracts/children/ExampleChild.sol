//SPDX-License-Identifier: MIT

// Author: Nithronium

pragma solidity ^0.8.0;

import "../utils/DaosmanChild.sol";

contract ExampleChild is DaosmanChild {

    uint public myVar;

    constructor(uint initialVal) DaosmanChild() {
        myVar = initialVal;
    }

    function get() public view returns (uint) {
        return myVar;
    }

    function set(uint newVar) public returns (bool) {
        myVar = newVar;
        return true;
    }
    
}