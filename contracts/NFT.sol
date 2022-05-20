// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @title                      NFT
/// @notice                     Inherits OpenZeppelin ERC721 and enables
///                             minting with 1000 ERC20 tokens at coinAddress
contract NFT is ERC721, Ownable {

    using Counters for Counters.Counter; // Safely increments tokenId during minting
    
    /// VARIABLES ///

    IERC20 public coinAddress; // Address of ERC20 token to spend for minting

    uint256 public fee = 1000; // Minting cost in tokens
    
    Counters.Counter private _tokenIdCounter; // NFT tokenId incrementer

    /// CONSTRUCTOR ///

    /// @notice                 Initializes ERC721 NFT called NFT with symbol
    ///                         LNM (Linum)
    /// @param _coinAddress     Contract address of ERC20 for minting
    /// @dev                    Uses COIN to mint                   
    constructor(address _coinAddress) ERC721("NFT", "LNM") {
    	coinAddress = IERC20(_coinAddress);
    }

    /// FUNCTIONS ///

    /// @notice                 Minting function
    /// @dev                    Overrides ERC721 safeMint() to accept 1000 COIN
    function safeMint() public {
    	coinAddress.transferFrom(msg.sender, address(this), fee);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    /// @notice                 Token balance withdrawal 
    /// @dev                    Allows contract owner to withdraw tokens from contract
    function rugTheFunds() public onlyOwner {
    	coinAddress.transfer(msg.sender, coinAddress.balanceOf(address(this)));
    }
}
