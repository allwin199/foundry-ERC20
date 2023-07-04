// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        DeployOurToken deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);

        ourToken.transfer(bob, STARTING_BALANCE);
        // setting bob with starting balance
    }

    function testBobBalance() public {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowanceWorks() public {
        uint256 initalAllowance = 1000;

        // Bob approves Alice to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initalAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        uint256 amount = 1000;
        vm.prank(msg.sender);
        ourToken.transfer(alice, amount);
        assertEq(ourToken.balanceOf(alice), amount);
    }
}
