//SPDX-License-Identifier: MIT

// Author: Nithronium

pragma solidity ^0.8.0;

interface IDaosmanChild {
    function getChildIndex() external view returns (uint256);
    function setChildIndex() external returns (bool);
}