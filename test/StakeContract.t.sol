
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {OwnerUpOnly, Unauthorized} from "../src/OwnerUpOnly.sol";
import {StakeContract} from "../src/StakeContract.sol";
import {MockERC20} from "../src/mocks/MockERC20.sol";

contract StakeContractTest is Test {
  StakeContract public stakeContract;
  MockERC20 public mockERC20;
  function setUp() public {
    stakeContract = new StakeContract();
    mockERC20 = new MockERC20();
  }

  function testExample(uint8 amount) public {
    mockERC20.approve(address(stakeContract), amount);
    bool stakePassed = stakeContract.stake(amount, address(mockERC20));
    vm.roll(55);
    assertTrue(stakePassed);
  }
}
