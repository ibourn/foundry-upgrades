// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/upgradeable/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    // SAME as not having a constructor
    ///@custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        // make sure the initializers are not called during the upgrade
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender); // set the owner to msg.sender
        // optionnal
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address) internal override {
        // Add checks for authorization of upgrade here
    }
}
