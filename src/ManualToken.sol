// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {
    mapping(address owner => uint256 amount) private s_balances;

    function Name() public pure returns (string memory) {
        return "Manual Token";
    }

    function symbol() public pure returns (string memory) {
        return "ETTH";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100e18
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(s_balances[msg.sender] >= _amount, "Insufficient Funds");
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        return true;
    }
}

// https://eips.ethereum.org/EIPS/eip-20
// ERC 20 Reference
