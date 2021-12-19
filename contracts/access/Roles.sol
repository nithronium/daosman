//SPDX-License-Identifier: MIT

// Author: Nithronium

pragma solidity ^0.8.0;

abstract contract Roles {

    /**
     * @dev the role bytes must be unique for every role
     */

    struct RoleData {
        bool isOwnable_;
        address owner_;
        bytes32 roleHash_;
    }

    uint256 private _roleCount;
    mapping(uint256 => RoleData) private _roles;
    mapping(bytes32 => uint256) private _rolesReverse;

    function registerRole(bytes32 roleHash, bool isOwnable) public returns (bool) {
        require(_rolesReverse[roleHash] == 0,"Roles: role already registered");

        _roleCount++;
        _roles[_roleCount].isOwnable_ = isOwnable;
        if(isOwnable) {
            _roles[_roleCount].owner_ = msg.sender;
        } else {
            _roles[_roleCount].owner_ = address(0);
        }

        _roles[_roleCount].roleHash_ = roleHash;

        _rolesReverse[roleHash]= _roleCount;

        return true;
    }

    function _hasRole(bytes32 roleHash, address user) internal {

    }

}