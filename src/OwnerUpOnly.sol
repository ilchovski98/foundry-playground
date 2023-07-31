// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

error Unauthorized();

contract OwnerUpOnly {
  event Incremented(uint256 indexed currentCount, uint256 incrementWith);
  address public immutable owner;
  uint256 public count;

  constructor() {
    owner = msg.sender;
  }

  function increment() external {
    if (msg.sender != owner) {
      revert Unauthorized();
    }
    count++;
    emit Incremented(count, 1);
  }
}
