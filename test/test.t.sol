pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import {Factory} from "src/factory.sol";
import {Child} from "src/child.sol";
import {ExampleToken} from "src/example_token.sol";

contract FactoryTest is Test {
    Factory public factory;
    Child public child;
    ExampleToken public exampleToken;

    // ============================================================
    //               TEST CONFIGURATION VARIABLES
    // ============================================================

    address ADMIN = address(1);
    address NOT_ADMIN = address(2);
    uint256 TEST_AMOUNT = 100000000;

    // ============================================================
    //                   TEST ENVIRONMENT SETUP
    // ============================================================

    function setUp() public {
        exampleToken = new ExampleToken(ADMIN);
        address exampleToken_address = address(exampleToken);
        factory = new Factory(exampleToken_address);
    }

    // ============================================================
    //                          TESTS
    // ============================================================
    //              TEST # 1: Child creation check
    // ============================================================

    function testChildTransferIsCreated() public {
        // ADMIN == user who "owns" the child contracts
        // because it is the one to initialise it.
        vm.startPrank(ADMIN);
        // Step 1: user (ADMIN) calls Factory to create a new transfer
        factory.createTransfer(TEST_AMOUNT);
        // Step 2: Read the transfer state from Factory mapping
        (bool created,,) = factory.transferIdMapping(ADMIN, 0);
        // Step 3: Verify that the transfer was successfully created
        // created == true means the Child contract was deployed and recorded
        assertEq(created, true);
        vm.stopPrank();
    }

    // ============================================================
    //           TEST # 2: Child stores correct admin
    // ============================================================

    function testChildAdmin() public {
        // ADMIN == user who "owns" the child contracts
        // because it is the one to initialise it.
        vm.startPrank(ADMIN);
        // Step 1: user (ADMIN) calls Factory to create a new transfer
        factory.createTransfer(TEST_AMOUNT);
        // Step 2: Read the child contract address from Factory mapping
        (,, address childAddr) = factory.transferIdMapping(ADMIN, 0);
        // Step 3: Verify that the Child contract correctly stored the ADMIN address
        // This ensures ownership was correctly passed during deployment
        child = Child(childAddr);
        assertEq(child.ADMIN_ADDRESS(), ADMIN);
        vm.stopPrank();
    }

    // ============================================================
    //              TEST # 3: Full transfer flow
    // ============================================================

    function testChildDeploysAndWorks() public {
        // ADMIN == user who "owns" the child contracts
        // because it is the one to initialise it.
        vm.startPrank(ADMIN);
        // Step 1: Create transfer (deploy Child contract)
        factory.createTransfer(TEST_AMOUNT);
        // Step 2: Get deployed Child address
        (,, address childAddr) = factory.transferIdMapping(ADMIN, 0);
        // Step 3: Approve Child contract to spend user's (ADMIN's) tokens
        exampleToken.approve(childAddr, TEST_AMOUNT);
        // Step 4: Execute deposit through Child contract
        Child(childAddr).Deposit(TEST_AMOUNT);
        // Step 5: Check that Factory marked transfer as completed
        (, bool completed,) = factory.transferIdMapping(ADMIN, 0);
        assertEq(completed, true);
        vm.stopPrank();
    }
}
