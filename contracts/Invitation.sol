
pragma solidity ^0.6.0;

contract Invitation {
    address public _operator;
    mapping(address => address)  relationship;
    mapping(address => address[]) public invitationStorage;
    mapping(address => uint) public numOfInvitations;
    constructor() public{
        _operator =  msg.sender;
    }
    
    function transferOperator(address newOperator_) public onlyOperator{
        require(
            newOperator_ != address(0),
            'operator: zero address given for new operator'
        );
        _operator = newOperator_;
    }
    
    modifier onlyOperator() {
        require(
            _operator == msg.sender,
            'operator: caller is not the operator'
        );
        _;
    }
    
    function setInviter(address invitee , address inviter) public onlyOperator{
        if(relationship[invitee] != address(0)) return;  //No modification allowed
        relationship[invitee] = inviter;
        invitationStorage[inviter].push(invitee);
        numOfInvitations[inviter] = numOfInvitations[inviter] + 1;
    }

    function getInviter(address invitee) public view returns (address inviter){
        return relationship[invitee];
    }
}