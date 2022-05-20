// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

/// @title                      Pausable ERC20
/// @notice                     Inherits OpenZeppelin ERC20 and pausable 
///                             extension to enable/disable transfers
contract COIN is ERC20, Pausable, Ownable {

    /// CONSTRUCTOR ///

    /// @notice                 Overridden constructor to initialize
    ///                         ERC20 called COIN
    /// @dev                    Premints 10000 tokens to msg.sender 
    constructor() ERC20("COIN", "COIN") {
        _mint(msg.sender, 10000);
    }

    /// FUNCTIONS ///

    /// @notice                 Freezes token contract to disable transfers
    /// @dev                    Can only be called by contract owner
    function pause() public onlyOwner {
        _pause();
    }

    /// @notice                 Unfreezes token contract to enable transfers
    ///                         after being paused
    /// @dev                    Can only be called by contract owner
    function unpause() public onlyOwner {
        _unpause();
    }

    /// @notice                 Before transfer hook
    /// @dev                    Checks to ensure token is not paused
    ///                         before transfer
    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }
}