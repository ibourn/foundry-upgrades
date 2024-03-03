// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/upgradeable/access/OwnableUpgradeable.sol";

/*
 * Intializable and OwnableUpgradeable are not necessary, depending on the use case
 */
contract BoxV2 is UUPSUpgradeable {
    uint256 internal number;

    // constructor() public {
    //     // make sure the initializers are not called during the upgrade
    //     _disableInitializers();
    // }

    // function initialize() public initializer {
    //     __Ownable_init(); // set the owner to msg.sender
    //     // optionnal
    //     __UUPSUpgradeable_init();
    // }

    function setNumber(uint256 _number) external {
        number = _number;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address) internal override {
        // Add checks for authorization of upgrade here
    }
}
