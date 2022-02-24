// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract Allowance is Ownable {

    using SafeMath for uint256;

    mapping(address => uint256) public allowance;

    event AllowanceChanged(address indexed _forWho, address indexed _fromWho, uint256 _oldAmount, uint256 _newAmount);

    modifier ownerOrAllowed(uint256 _amount) {
        require(allowance[msg.sender] >= _amount, 'You are not allowed');
        _;
    }

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        allowance[_who] = _amount;
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        allowance[_who] = allowance[_who].sub(_amount);
        emit AllowanceChanged(_who, msg.sender, allowance[_who], allowance[_who].sub(_amount));
    }
}
