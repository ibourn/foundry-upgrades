// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("OWNER");
    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
        // proxy points to BoxV1
    }

    function test_ProxyStartsAtBoxV1() public {
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxy).version());
    }

    function test_ShouldRevertCallingV2FunctionOnV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    function test_Upgrade() public {
        BoxV2 box = new BoxV2();

        upgrader.upgradeBox(proxy, address(box));

        uint256 expectedValue = 2;
        assertEq(expectedValue, BoxV2(proxy).version());
    }

    function test_NumberIsSetCorrectly_AfterUpgrade() public {
        BoxV2 box = new BoxV2();

        upgrader.upgradeBox(proxy, address(box));

        BoxV2(proxy).setNumber(42);
        assertEq(42, BoxV2(proxy).getNumber());
    }
}
