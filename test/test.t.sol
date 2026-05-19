pragma solidity ^0.8.4;

import "forge-std/Test.sol";
import {Factory} from "src/factory.sol";
import {Child} from "src/child.sol";
import {ExampleToken} from "src/example_token.sol";

contract FactoryTest is Test {
    Factory public factory;
    Child public child;
    ExampleToken public exampleToken;

    // test variables
    address ADMIN = address(1);
    address NOT_ADMIN = address(2);
    uint256 TEST_AMOUNT = 100000000;

    function setUp() public {
        exampleToken = new ExampleToken(ADMIN);
        address exampleToken_address = address(exampleToken);
        factory = new Factory(exampleToken_address);
    }

    function testChildTransferIsCreated() public {
        vm.startPrank(ADMIN);
        factory.createTransfer(TEST_AMOUNT);
        (bool created,,) = factory.transferIdMapping(ADMIN, 0);
        assertEq(created, true);
        vm.stopPrank();
    }

    function testChildAdmin() public {
        vm.startPrank(ADMIN);
        factory.createTransfer(TEST_AMOUNT);
        (,, address childAddr) = factory.transferIdMapping(ADMIN, 0);
        child = Child(childAddr);
        assertEq(child.ADMIN_ADDRESS(), ADMIN);
        vm.stopPrank();
    }

    // function testChildDeploysAndWorks() public {
    //  vm.startPrank(ADMIN);

    // factory.createTransfer(TEST_AMOUNT);

    //  (,,, address childAddr) = factory.transferIdMapping(ADMIN, 0);

    //   childAddr.deposit(TEST_AMOUNT);

    //       (,bool completed,,) = factory.transferIdMapping(ADMIN, 0);
    //       assertEq(completed, true);

    //    vm.stopPrank();
    //}

    //   function testEncryptedDataUpdate public {
    //      vm.startPrank(ADMIN);

    //      vm.stopPrank();
    //  }
}
