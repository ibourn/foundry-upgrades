// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 box = new BoxV2();
        vm.stopBroadcast();

        address proxy = upgradeBox(mostRecentlyDeployed, address(box));
        return proxy;
    }

    function upgradeBox(address proxy, address newBox) public returns (address) {
        vm.startBroadcast();
        BoxV1 BoxV1proxy = BoxV1(proxy);
        BoxV1proxy.upgradeToAndCall(address(newBox), new bytes(0)); // point the proxy to the new implementation
        vm.stopBroadcast();
        return address(BoxV1proxy);
    }
}
