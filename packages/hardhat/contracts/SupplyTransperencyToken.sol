    // SPDX-License-Identifier: MIT
    // Compatible with OpenZeppelin Contracts ^5.0.0
    pragma solidity ^0.8.19;

    import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";

    contract SupplyTransperencyToken is ERC721, ERC721Burnable, Ownable {
        uint256 private _nextTokenId;
        address[] public signers; // Lista de endereços dos signatários
        mapping(address => bool) public isSigner; // Mapeamento para verificar se um endereço é um signatário
        mapping(bytes32 => mapping(address => bool)) public hasSigned; // Mapeamento para verificar se um hash de mensagem foi assinado por um signatário
        

        event SignatureAdded(address indexed signer, bytes32 indexed messageHash);

        constructor() ERC721("SupplyTransperencyToken", "STT") {}

        function safeMint(address to, bytes32 messageHash) public onlyOwner {
            require(isFullySigned(messageHash), "Transaction not fully signed");
            uint256 tokenId = _nextTokenId++;

            _safeMint(to, tokenId);
        }

        function getAllSigners() public view returns (address[] memory) {
            return signers;
        }

        function setSingleSigner(address signer) public onlyOwner {
            signers.push(signer);
            isSigner[signer] = true;
        }
        // Função para adicionar uma assinatura
        function addSignature(bytes32 messageHash) public {
            require(isSigner[msg.sender], "Only signers can add signatures");
            require(!hasSigned[messageHash][msg.sender], "Signature already added");

            hasSigned[messageHash][msg.sender] = true;

            emit SignatureAdded(msg.sender, messageHash);
        }

        // Função para verificar se uma transação foi assinada por todos os signatários
        function isFullySigned(bytes32 messageHash) public view returns (bool) {
            for (uint i = 0; i < signers.length; i++) {
                if (!hasSigned[messageHash][signers[i]]) {
                    return false;
                }
            }
            return true;
        }

        function changeSigner(address[] memory _signers, address signer, address removeSigner) public view returns (bool) {
            for (uint i = 0; i < signers.length; i++) {
                if (_signers[i] == removeSigner) {
                    _signers[i] = signer;
                    return true;
                }
            }
            return false;   
        }
    }
