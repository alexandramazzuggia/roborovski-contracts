// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract MetadataNft is ERC721, Ownable {
    using Strings for uint256;

    string private _contract =
        "https://ipfs.roborovski.org/ipfs/QmTey2rnpTmcR5w2jWxXGc8ysd9rCYF2ZTwscXPHqu3QD8/contract.json";
    string private _base =
        "https://ipfs.roborovski.org/ipfs/QmTey2rnpTmcR5w2jWxXGc8ysd9rCYF2ZTwscXPHqu3QD8/";
    string private _ext = ".json";

    function contractURI() external view returns (string memory) {
        return _contract;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        return
            bytes(_base).length != 0
                ? string(abi.encodePacked(_base, tokenId.toString(), _ext))
                : "";
    }

    function setContractURI(string memory uri_) external onlyOwner {
        _contract = uri_;
    }

    function setBaseURI(string memory uri_) external onlyOwner {
        _base = uri_;
    }

    function setBaseExtension(string memory extension_) external onlyOwner {
        _ext = extension_;
    }
}
