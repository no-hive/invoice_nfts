// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

// https://docs.chain.link/vrf/v2-5/subscription/test-locally#add-the-consumer-contract-to-your-subscription

import {Script} from "forge-std/Script.sol";
import {Child} from "../src/child.sol";
import {Factory} from "../src/factory.sol";

address constant USDT_ADDRESS = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

contract FactoryScript is Script {
    Factory public factory;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        factory = new Factory(USDT_ADDRESS);

        vm.stopBroadcast();
    }
}
