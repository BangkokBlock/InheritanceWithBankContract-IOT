//SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
import "./Ownable.sol";

contract Destroyable is Ownable {

   function destroyContract() public onlyOwner {
        selfdestruct(owner);
    }
}