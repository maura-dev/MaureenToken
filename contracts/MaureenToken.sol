// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MaureenToken {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 totalSupply_;

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
    constructor(){
        name = "MaureenToken";
        symbol ="MT";
        decimals = 18;
        //setting my total supply
        totalSupply_ = 1000000 *(10 ** 18);
        //assigning the total supply to the deployer
        balances[msg.sender] = totalSupply_;
    }

    //ERC20 standard functions
    function totalSupply() public view returns (uint256){
        return totalSupply_;
    }

    function balanceOf(address holderAddress) public view returns (uint) {
        return balances[holderAddress];
    }

    function allowance(address tokenOwner, address spender)
    public view returns (uint){
        return allowed[tokenOwner][spender];
    }

    function transfer(address to, uint tokens) public returns (bool){
        require(tokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint tokens)  public returns (bool){
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

   function transferFrom(address owner, address buyer, uint tokens) public returns (bool) {
        require(tokens <= balances[owner]);
        require(tokens <= allowed[owner][msg.sender]);
        balances[owner] = balances[owner] - tokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - tokens;
        balances[buyer] = balances[buyer] + tokens;
        emit Transfer(owner, buyer, tokens);
        return true;
    }
}