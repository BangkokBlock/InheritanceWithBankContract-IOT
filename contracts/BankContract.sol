//SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma abicoder v2;
import "./Ownable.sol";
import "./Destroyable.sol";

contract Bank is Ownable, Destroyable {

    mapping(address => uint) public balance;

    event depositDone (uint amount, address indexed depositedTo);

    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        emit depositDone (msg.value, msg.sender);
        return balance[msg.sender];
    }

    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    function withdraw(uint amount) public payable onlyOwner returns (uint) {
        require(balance[msg.sender] >= amount);
        payable(msg.sender).transfer(amount);
        balance[msg.sender] -= amount;
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public payable {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer funds to yourself");
        uint previousSenderBalance = balance[msg.sender];
        _transfer(msg.sender, recipient, amount);
        assert(balance[msg.sender] == previousSenderBalance - amount);     
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }

}