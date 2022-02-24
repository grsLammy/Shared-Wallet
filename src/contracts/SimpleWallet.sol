// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import './Allowance.sol';

contract SimpleWallet is Allowance {

    event MoneySent(address indexed _from, address indexed _to, uint256 _amount);
    event MoneyRecieved(address indexed _from, uint256 _amount);

    function withdrawMoney(address payable _to, uint256 _amount) public onlyOwner ownerOrAllowed(_amount)  {
        _to.transfer(_amount);
        if(msg.sender == owner) {
            reduceAllowance(msg.sender, _amount); 
        }
        emit MoneySent(msg.sender, _to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override onlyOwner {
        revert("Can't renounce ownership of the contract");
    }

    fallback() external payable {
        
    }

    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
    }
}
