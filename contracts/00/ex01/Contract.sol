// SPDX-License-Identifier: MIT
pragma solidity >=0.4.25 <0.9.0;

contract Contract {
    address payable public owner;
    uint256 public count; // Will automatically have a getter function, because it is public

    // Event to log when ether is received
    // a way to log and notify external entities (such as user interfaces or other smart contracts)
    // about specific occurrences within a smart contract
    event ReceivedEther(address sender, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; // Continue execution
    }

    constructor(address payable _owner) {
        owner = _owner; // Set the deployer of the contract as the owner
        count = 42;
    }

    receive() external payable {
        emit ReceivedEther(msg.sender, msg.value);
    }

    function withdrawAll() external onlyOwner {
        owner.transfer(address(this).balance);
    }

    // pure functions do not read or modify the state of the contract
    function fibonnaci(uint256 n) external pure returns (uint256) {
        (uint256 a, uint256 b) = (0, 1);
        for (uint256 i = 0; i < n; i++) {
            (a, b) = (b, a + b);
        }
        return a;
    }
}
