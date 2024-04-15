// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyFinalsActivity2 {
    address immutable public owner;
    uint public immutable creationTime;
    uint public constant INITIAL_ETH_AMOUNT = 100 ether;
    uint public remainingEth;

    event EtherReceived(address sender, uint amount);
    event EtherSent(address recipient, uint amount);
    event ContractDestroyed(address recipient, uint amount);

    constructor() {
        owner = msg.sender;
        creationTime = block.timestamp;
        remainingEth = INITIAL_ETH_AMOUNT;
    }

    fallback() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    receive() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    function receiveAndEmit() external payable {
        emit EtherReceived(msg.sender, msg.value);
    }

    function sendEther(address payable _to, uint _amount) external {
        require(msg.sender == owner, "Only owner can call this function");
        require(address(this).balance >= _amount, "Insufficient balance");
        _to.transfer(_amount);
        emit EtherSent(_to, _amount);
    }

    function destroy() external {
        require(msg.sender == owner, "Only owner can call this function");
        payable(payable(owner));
        emit ContractDestroyed(owner, address(this).balance);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}