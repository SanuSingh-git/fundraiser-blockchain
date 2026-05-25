// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ReentrancyGuard.sol";

contract Fundraiser is ReentrancyGuard{
    string public title;
    string public description;
    uint public goal;
    uint public deadline;
    uint public totalRaised;
    bool public withdrawn;
    address public owner;

    mapping(address => uint) public donations;

    event Donated(address indexed donor, uint amount, uint newTotal);
    event FundsWithdrawn(address indexed owner, uint amount);
    event Refunded(address indexed donor, uint amount);
    event GoalReached(uint totalRaised);

    constructor(
            string memory _title,
            string memory _description,
            uint _goalInWei,
            uint _durationSeconds
        )
    {
        require(_goalInWei>0,"Goal must be > 0");
        require(_durationSeconds>0,"Duration must be > 0");

        title=_title;
        description=_description;
        goal=_goalInWei;
        deadline= block.timestamp+_durationSeconds;
        owner=msg.sender;
    }

    function donate() external payable{
        require(block.timestamp<deadline,"Campaign ended");
        require(!withdrawn,"Funds already withdrawn");
        require(msg.value>0,"No ETH sent");

        donations[msg.sender]+=msg.value;
        totalRaised+=msg.value;

        if(totalRaised>=goal){
            emit GoalReached(totalRaised);
        }

        emit Donated(msg.sender, msg.value, totalRaised);
    }

    function withdraw() external nonReentrant{
        require(msg.sender==owner,"Only owner");
        require(!withdrawn,"Already withdrawn");

        uint amount=address(this).balance;

        withdrawn=true;

        (bool success, )= payable(owner).call{value:amount}("");
        require(success,"Transfer failed");

        emit FundsWithdrawn(owner,amount);
    }

    function refund() external nonReentrant{
        require(block.timestamp>= deadline,"Campaign still active");
        require(!withdrawn,"Funds already withdrawn");

        uint amount =donations[msg.sender];
        require(amount>0,"Nothing to refund");

        donations[msg.sender]=0;

        (bool success, )=payable(msg.sender).call{value:amount}("");
        require(success,"Refund failed");

        emit Refunded(msg.sender,amount);
    }

    function getStatus() external view returns(
            bool isActive,
            bool goalReached,
            uint remaining,
            uint timeLeft
        )
    {
        goalReached=totalRaised>=goal;
        isActive=block.timestamp<deadline && !withdrawn;
        remaining=goal>totalRaised ? (goal-totalRaised):0;
        timeLeft=block.timestamp<deadline ? (deadline-block.timestamp):0;
    }
}
