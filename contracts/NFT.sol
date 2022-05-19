// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    IERC20 public coinAddress;
    uint256 public fee = 1000 * 10 ** 18;

    Counters.Counter private _tokenIdCounter;

    constructor(address _coinAddress) ERC721("NFT", "LNM") {
    	coinAddress = IERC20(_coinAddress);
    }

    function safeMint() public {
    	coinAddress.transferFrom(msg.sender, address(this), fee);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function rugTheFunds() public onlyOwner {
    	coinAddress.transfer(msg.sender, coinAddress.balanceOf(address(this)));
    }
}
