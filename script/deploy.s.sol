// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// https://docs.chain.link/vrf/v2-5/subscription/test-locally#add-the-consumer-contract-to-your-subscription

import {Script} from "forge-std/Script.sol";
import {Child} from "../src/child.sol";
import {Factory} from "../src/factory.sol";

contract FactoryScript is Script {
    Factory public factory;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        factory = new Factory();

        vm.stopBroadcast();
    }
}
