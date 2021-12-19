//SPDX-License-Identifier: MIT

// Author: Nithronium

/**
 * I want this roles contract to be as flexible as possible
 * later I'll implement a functions contract and allow some 
 * role based function registering on the DAO as well as 
 * registering new smart contracts with the DAO
 */

pragma solidity ^0.8.0;

abstract contract Roles {

    /**
     * @dev the role bytes must be unique for every role
     */

    struct RoleData {
        bool isRegistered_;
        bool isPublic_;
        bool isOwnable_;
        address owner_;
        mapping(address=>bool) members_;
    }

    uint256 private _roleCount;
    mapping(bytes32 => RoleData) private _roles;
    mapping(uint256 => bytes32) private _roleIds;

    modifier hasRoleAccess(address user, bytes32 roleHash) {
        require(_roles[roleHash].owner_ == user || _roles[roleHash].isOwnable_ == false, "No access");
        _;
    }

    modifier roleExists(bytes32 roleHash) {
        require(_roles[roleHash].isRegistered_,"Role doesn't exist");
        _;
    }
    function registerRole(bytes32 roleHash, bool isPublic, bool isOwnable) public returns (bool) {
        require(_roles[roleHash].isRegistered_ == false,"Roles: role already registered");
        _roles[roleHash].isRegistered_ = true;
        _roleCount++;
        _roles[roleHash].isOwnable_ = isOwnable;
        _roles[roleHash].isPublic_ = isPublic;
        if(isOwnable) {
            _roles[roleHash].owner_ = msg.sender;
        } else {
            _roles[roleHash].owner_ = address(0);
        }

        _grantRole(msg.sender,roleHash);

        _roleIds[_roleCount]= roleHash;

        return true;
    }

    function grantRole(address user, bytes32 roleHash) public 
        hasRoleAccess(msg.sender, roleHash) roleExists(roleHash) returns (bool) {
        _grantRole(user, roleHash);
        return true;
    }

    function revokeRole(address user, bytes32 roleHash) public 
        hasRoleAccess(msg.sender, roleHash) roleExists(roleHash) returns (bool) {
        _revokeRole(user,roleHash);
        return true;
    }

    function renounceRole(bytes32 roleHash) public roleExists(roleHash) returns (bool) {
        _revokeRole(msg.sender,roleHash);
        return true;
    }

    function _grantRole(address user, bytes32 roleHash) internal returns (bool) {
        _roles[roleHash].members_[user] = true;
        return true;
    }

    function _revokeRole(address user, bytes32 roleHash) internal returns (bool) {
        _roles[roleHash].members_[user] = false;
        return true;
    }

    function hasRole(address user, bytes32 roleHash) public view returns (bool) {
        return _roles[roleHash].members_[user];
    }


}