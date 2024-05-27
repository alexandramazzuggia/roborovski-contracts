// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./lib/MetadataNft.sol";
import "./lib/Recoverable.sol";

contract RoborovskiRetreatEdition is
    ERC721,
    ERC721Enumerable,
    MetadataNft,
    Recoverable
{
    constructor(address[] memory recipients)
        ERC721("Roborovski Retreat Edition", "ROBO-RE")
    {
        for (uint256 i = 0; i < recipients.length; i++) {
            _safeMint(recipients[i], i + 1);
        }
    }

    function rawOwnerOf(uint256 tokenId) external view returns (address) {
        if (_exists(tokenId)) return ownerOf(tokenId);
        return address(0);
    }

    function tokensOfOwner(address owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256 tokenCount = balanceOf(owner);
        require(tokenCount > 0, "ERC721Enumerable: owner index out of bounds");
        uint256[] memory tokenIds = new uint256[](tokenCount);
        for (uint256 i = 0; i < tokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(owner, i);
        }
        return tokenIds;
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, MetadataNft)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
