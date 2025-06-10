// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Chai {
    struct Memo {
        string name;
        string message;
        uint256 timestamp;
        address from;
    }

    Memo[] private memos;           // Changed to private for encapsulation
    address payable public owner;   // Marked public to allow viewing the owner address

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    constructor() {
        owner = payable(msg.sender);
    }

    function buyChai(string calldata name, string calldata message)
        external
        payable
    {
        require(msg.value > 0, "Please pay more than 0 ether");

        owner.transfer(msg.value);
        memos.push(Memo(name, message, block.timestamp, msg.sender));

        emit NewMemo(msg.sender, block.timestamp, name, message); // emits event
    }

    function getMemos() external view returns (Memo[] memory) {
        return memos;
    }

    function withdrawTips() external {
        require(msg.sender == owner, "Only the owner can withdraw");
        owner.transfer(address(this).balance);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
