// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol';
import "@openzeppelin/contracts/access/AccessControl.sol";
import '@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol';

contract GivethImpactQuest is ERC1155Burnable, AccessControl, ERC1155URIStorage {
    using SafeERC20 for IERC20;

    error NoTokenExists(uint256 tokenId);

    event Mint(address recipient, uint256 tokenId, uint256 amount);
    event MintBatch(address recipient, uint256 totalAmounts);

    string baseURI;
    uint96 uniqueTokens = 0;
    bytes32 public constant URI_SETTER_ROLE = keccak256("URI_SETTER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");


    constructor(string memory _baseURI) ERC1155(_baseURI) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(URI_SETTER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        baseURI = _baseURI;
    }

    function mint(address account, uint256 id, uint256 amount) external onlyRole(MINTER_ROLE) {

        if (id > uniqueTokens) {
            revert NoTokenExists(id);
        }

        _mint(account, id, amount, '');
        emit Mint(account, id, amount);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts) external onlyRole(MINTER_ROLE) {
        uint256 totalAmount;

            for (uint256 i = 0; i < ids.length;) {
                if (ids[i] > uniqueTokens) {
                    revert NoTokenExists(ids[i]);
                }
                unchecked {
                    i++;
                }
        }
        _mintBatch(to, ids, amounts, '');
        emit MintBatch(to, totalAmount);
    }

    function uri(uint256 tokenId) public view virtual  override (ERC1155, ERC1155URIStorage) returns (string memory) {
        return super.uri(tokenId);
    }


    function setTokenURI(uint256 tokenId, string memory tokenURI) external onlyRole(URI_SETTER_ROLE) {
        _setURI(tokenId, tokenURI);
    }

    function setBaseURI(string memory _baseURI) external onlyRole(URI_SETTER_ROLE) {
        _setBaseURI(_baseURI);
    }

    function addToken(string memory tokenURI) external onlyRole(URI_SETTER_ROLE) {
        uniqueTokens++;
        _setURI(uniqueTokens, tokenURI);
    }

    function getTokenInfo(uint tokenId) external view returns (string memory tokenURI) {
            tokenURI = uri(tokenId);
    }


    function getUniqueTokens() external view returns (uint96) { 
        return uniqueTokens;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC1155, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function transfer()
}
