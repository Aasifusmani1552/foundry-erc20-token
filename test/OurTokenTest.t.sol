// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";
import {OurToken} from "src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address Alice = makeAddr("Alice");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
    }

    function testAllowancesWorks() public {
        uint256 initialAllowance = 1000; //the amount which we allow the approved user to spend

        // Bob approves alice to spend token on his behalf
        vm.prank(bob);
        ourToken.approve(Alice, initialAllowance);

        uint256 tranferAmount = 500;
        vm.prank(Alice);
        ourToken.transferFrom(bob, Alice, tranferAmount);

        assertEq(ourToken.balanceOf(Alice), tranferAmount);
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - tranferAmount);
    }
}
