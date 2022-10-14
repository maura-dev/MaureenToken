// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Wallet {
    address private owner;

    mapping(address => uint256) public balances;

    modifier onlyOwner(){
         require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // contract events
    event Sent(uint256 _amount, address _to);
    event Deposit(uint256 _amount);


    constructor(){
        //setting deployer as owner 
        owner = msg.sender;
    }

    //function to send ether to external address
    function sendEth(address payable _to) public payable {
        uint256 amount = msg.value;
        require(amount > 0, "Enter valid amount");
        require(balances[msg.sender] >= amount, "Insufficient funds in wallet");
        (bool success, ) = payable(_to).call{value: amount}("Sent successfully");
        require(success == true, "Transaction failed");
        balances[msg.sender] = balances[msg.sender] - amount;
        emit Sent( amount, _to);
    }

    //function to deposit ether into contract
    function depositEth() public payable {
        require(msg.value > 0, "Enter valid amount");
        balances[msg.sender] = balances[msg.sender] + msg.value;
        emit Deposit(msg.value);
    }

    //function to get the eth balance of the contract
    function getBalance() public view onlyOwner returns(uint256) {
        return address(this).balance;
    }

    //functions to receive eth into contract
    receive() external payable{

    }

    fallback() external payable{

    }


}