// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DocumentSigner {
    // Armazenamento do hash do documento
    bytes32 private documentHash;

    // Evento para quando o hash do documento é atualizado
    event DocumentUpdated(bytes32 newHash);

    // Função para atualizar o hash do documento (setter)
    function setDocumentHash(string memory document) public {
        documentHash = keccak256(abi.encodePacked(document));
        emit DocumentUpdated(documentHash);
    }

    // Função para recuperar o hash atual do documento (getter)
    function getDocumentHash() public view returns (bytes32) {
        return documentHash;
    }

    // Função para verificar se um documento fornecido corresponde ao documento assinado
    function isDocumentSigned(string memory document) public view returns (bool) {
        return keccak256(abi.encodePacked(document)) == documentHash;
    }
}