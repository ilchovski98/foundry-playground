// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {OwnerUpOnly, Unauthorized} from "../src/OwnerUpOnly.sol";

contract OwnerUpOnlyTest is Test {
    event Incremented(uint256 indexed currentCount, uint256 incrementWith);
    OwnerUpOnly public ownerUpOnly;

    function setUp() public {
      ownerUpOnly = new OwnerUpOnly();
    }

    function testIncrement() public {
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      ownerUpOnly.increment();
      assertEq(ownerUpOnly.count(), 8);
    }

    function test_RevertWhen_CallerIsNotOwner() public {
      vm.expectRevert(Unauthorized.selector);
      vm.prank(address(0));
      ownerUpOnly.increment();
    }

    function test_Event() public {
      // 1,2,3 = compare by indexed values (if different throw) 4 = check not indexed values as well (enable their comparison)
      vm.expectEmit(false, true, true, false);
      emit Incremented(2, 2);
      ownerUpOnly.increment();
    }
}
