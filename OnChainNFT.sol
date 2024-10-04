// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract OnChainNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;

    event Minted(uint256 tokenId);

    constructor() ERC721("OnChainNFT", "XNFT") Ownable(msg.sender) {}

    /* Converts an SVG to Base64 string */
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    /* Generates a tokenURI using Base64 string as the image */
    function formatTokenURI(
        string memory imageURI
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "GAMI UN-CHAINED", "description": "A simple SVG based on-chain NFT", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /* Mints the token */
    function mint(string memory svg) public onlyOwner {
        string memory imageURI = svgToImageURI(svg);
        string memory tokenURI = formatTokenURI(imageURI);

        _tokenIds++;
        uint256 newItemId = _tokenIds;

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit Minted(newItemId);
    }
}
