pragma solidity ^0.8.2;

import "./Allowance.sol";

contract SimpleWallet is Allowance{
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyRecieved(address indexed _from, uint _amount);
    
    function withdrawMoney(address payable _to,uint _amount) public ownerOrAllowed(_amount){
        require(_amount <= address(this).balance, "There is not enough funds stored in the smart contract");
        if(!isOwner()){
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public onlyOwner override{
        revert("Cant renounce Ownership");
    }
    
    fallback () external  payable{
        emit MoneyRecieved(msg.sender, msg.value);
    }
    
    
}